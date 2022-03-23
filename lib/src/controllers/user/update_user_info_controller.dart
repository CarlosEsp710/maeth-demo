import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

class UpdateUserInfoController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  String gender = "Selecciona tu sexo";
  List<String> genderList = [
    "Selecciona tu sexo",
    "Masculino",
    "Femenino",
  ];

  void update(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final _user = Provider.of<UserProvider>(context, listen: false).user;

      final token = await _credentials.getToken();
      _api.addHeader('Authorization', 'Bearer $token');

      Adapter adapter = _api;

      _user.firstName = firstNameController.text.toString();
      _user.lastName = lastNameController.text.toString();
      _user.email = emailController.text.toString();
      _user.gender = gender;

      try {
        showLoading(context);

        User updatedUser = User(await adapter.save(
            'users', _user.resourceObject) as ResourceObject);

        Navigator.pop(context);
        showSuccessAlert(
            context, 'Listo', 'Datos de usuario actualizados con éxito');
      } catch (e) {
        Navigator.pop(context);
        showErrorAlert(context, 'Error', e.toString());
      }
    }
  }
}
