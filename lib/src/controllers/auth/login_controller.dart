import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:maeth_demo/src/controllers/auth/auth_manager_controller.dart';
import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/controllers/auth/responses/auth_error_response.dart';
import 'package:maeth_demo/src/controllers/auth/responses/auth_response.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';

class LoginController {
  final CredentialsController _credentialsController = CredentialsController();
  final AuthManagerController _authController = AuthManagerController();

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final uri = Uri.parse('https://maeth-unicla.herokuapp.com/api/v1/login');

  void login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      showLoading(context);

      final body = {
        'email': emailController.text.toUpperCase().trim(),
        'password': passwordController.text.trim(),
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

        await _credentialsController.saveToken(data.plainTextToken);
        await _credentialsController.saveUserId(data.userId);

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
