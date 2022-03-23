import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:maeth_demo/src/providers/socket_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/controllers/auth/responses/auth_response.dart';

import 'package:maeth_demo/src/helpers/helpers.dart';

import 'package:maeth_demo/src/providers/user_provider.dart';

import 'package:maeth_demo/src/schemas/nutritionist_schema.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

import 'package:maeth_demo/src/views/auth/complete_profile_view.dart';
import 'package:maeth_demo/src/views/auth/login_view.dart';
import 'package:maeth_demo/src/views/nutritionist/checking_view.dart';
import 'package:maeth_demo/src/views/nutritionist/rejected_view.dart';
import 'package:maeth_demo/src/views/ui/navigation_view.dart';

class AuthManagerController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future isLoggedIn(BuildContext context) async {
    final token = await _credentials.getToken();
    final userId = await _credentials.getUserId();

    if (token == null || userId == null) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const LoginView(),
        ),
      );
    } else {
      _renewToken(context);
    }
  }

  Future getUser(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final token = await _credentials.getToken();
    final userId = await _credentials.getUserId();

    _api.addHeader('Authorization', 'Bearer $token');
    Adapter adapter = _api;

    try {
      userProvider.user =
          User(await adapter.find('users', userId) as ResourceObject);

      _redirect(context);
    } catch (e) {
      print(e);
    }
  }

  Future _renewToken(BuildContext context) async {
    final uri = Uri.parse('https://maeth-unicla.herokuapp.com/api/v1/renew');

    final body = {'device_name': await deviceName()};
    final token = await _credentials.getToken();

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${token.toString()}'
      },
    );

    if (response.statusCode == 200) {
      var data = authResponseFromJson(response.body);

      await _credentials.saveToken(data.plainTextToken);
      await _credentials.saveUserId(data.userId);

      getUser(context);
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const LoginView(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  Future _redirect(BuildContext context) async {
    final userService = Provider.of<UserProvider>(context, listen: false);
    final socketService = Provider.of<SocketProvider>(context, listen: false);

    if (userService.user.userType == 'Paciente') {
      await _isPatient(context);
      socketService.connect();
    } else if (userService.user.userType == 'Nutriólogo') {
      await _isNutritionist(context);
      socketService.connect();
    }
  }

  Future _isPatient(BuildContext context) async {
    final token = await _credentials.getToken();

    _api.addHeader('Authorization', 'Bearer $token');
    Adapter adapter = _api;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    User user = User(await adapter.find(
      'users',
      userProvider.user.id!,
      queryParams: {'include': 'patientProfile,articles'},
    ) as ResourceObject);

    if (user.hasPatientProfile.isEmpty) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const CompleteProfileView(),
          type: PageTransitionType.leftToRight,
        ),
      );
    } else {
      userProvider.user = user;

      Patient profile = Patient(await adapter.find(
        'patients',
        userProvider.user.patientProfileId!,
        queryParams: {'include': 'nutritionist,reports'},
      ) as ResourceObject);

      await _credentials.saveNutritionistId(profile.nutritionistId!);

      User myNutritionist = User(await adapter.find(
        'users',
        profile.nutritionistId!,
        queryParams: {'include': 'nutritionistProfile'},
      ) as ResourceObject);

      userProvider.myNutritionist = myNutritionist;

      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const NavigationView(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  Future _isNutritionist(BuildContext context) async {
    final token = await _credentials.getToken();

    _api.addHeader('Authorization', 'Bearer $token');
    Adapter adapter = _api;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    User user = User(await adapter.find(
      'users',
      userProvider.user.id!,
      queryParams: {'include': 'nutritionistProfile,articles'},
    ) as ResourceObject);

    if (user.hasNutritionistProfile.isEmpty) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const CompleteProfileView(),
          type: PageTransitionType.leftToRight,
        ),
      );
    } else {
      if (user.validation == 'Validando datos') {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const CheckingView(),
            type: PageTransitionType.fade,
          ),
        );
      } else if (user.validation == 'Rechazado') {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const RejectedView(),
            type: PageTransitionType.fade,
          ),
        );
      } else {
        userProvider.user = user;

        Nutritionist(await adapter.find(
          'nutritionists',
          userProvider.user.nutritionistProfileId!,
          queryParams: {'include': 'patients'},
        ) as ResourceObject);

        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const NavigationView(),
            type: PageTransitionType.fade,
          ),
        );
      }
    }
  }
}
