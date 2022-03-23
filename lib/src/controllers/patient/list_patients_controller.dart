import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/nutritionist_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:provider/provider.dart';

class ListPatientsController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Iterable<User>> listPatients(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Nutritionist nutritionist = Nutritionist(await adapter.find(
        'nutritionists',
        user.nutritionistProfileId!,
        queryParams: {'include': 'patients'},
      ) as ResourceObject);

      Iterable<String> ids = nutritionist.patientsId;

      Iterable<User> patients = (await adapter.findManyById('users', ids,
              queryParams: {'include': 'patientProfile'}))
          .map<User>((user) => User(user as ResourceObject))
          .toList();

      return patients;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
