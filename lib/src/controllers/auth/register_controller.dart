import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:maeth_demo/src/controllers/auth/auth_manager_controller.dart';
import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/controllers/auth/responses/auth_error_response.dart';
import 'package:maeth_demo/src/controllers/auth/responses/auth_response.dart';

import 'package:maeth_demo/src/helpers/helpers.dart';

class RegisterController {
  final CredentialsController _credentials = CredentialsController();
  final AuthManagerController _authController = AuthManagerController();

  final registerFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? date;

  String gender = "Selecciona tu sexo";
  List<String> genderList = [
    "Selecciona tu sexo",
    "Masculino",
    "Femenino",
  ];

  dynamic imageProfile;

  final uri = Uri.parse('https://maeth-unicla.herokuapp.com/api/v1/register');

  void register(BuildContext context, String type) async {
    if (imageProfile == null) {
      showErrorAlert(context, 'Error', 'La imágen de perfil es obligatoria');
    } else {
      if (registerFormKey.currentState!.validate()) {
        showLoading(context);

        String urlImage = await uploadPhoto(imageProfile, 'profile_images');

        final body = {
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'email': emailController.text.toUpperCase().trim(),
          'password': passwordController.text.trim(),
          'gender': gender,
          'type': type,
          'image_profile': urlImage,
          'birthday': date!.toIso8601String(),
          'device_name': await deviceName()
        };

        final response = await http.post(
          uri,
          body: jsonEncode(body),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json'
          },
        );

        Navigator.pop(context);

        if (response.statusCode == 200) {
          var data = authResponseFromJson(response.body);

          await _credentials.saveToken(data.plainTextToken);
          await _credentials.saveUserId(data.userId);

          _authController.getUser(context);
        } else {
          var badRequest = authErrorResponseFromJson(response.body);

          showErrorAlert(
            context,
            'Algo salió mal :(',
            badRequest.errors.first.detail,
          );
        }
      }
    }
  }
}
