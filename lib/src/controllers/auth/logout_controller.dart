import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:maeth_demo/src/providers/navigation_provider.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:page_transition/page_transition.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/views/auth/login_view.dart';
import 'package:provider/provider.dart';

class LogoutController {
  final CredentialsController _credentials = CredentialsController();

  final uri = Uri.parse('https://maeth-unicla.herokuapp.com/api/v1/logout');

  void logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final navigatorProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    final token = await _credentials.getToken();

    final response = await http.post(
      uri,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 204) {
      await _credentials.deleteToken();
      await _credentials.deleteUserId();

      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: const LoginView(),
          type: PageTransitionType.rightToLeft,
        ),
        (route) => false,
      );

      userProvider.user = null;
      userProvider.myNutritionist = null;
      navigatorProvider.selectedIndex = 0;
    }
  }
}
