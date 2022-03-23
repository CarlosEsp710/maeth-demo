import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';

class GetPatientController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Patient?> getPatient(BuildContext context, String id) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Patient patient = Patient(await adapter.find(
        'patients',
        id,
        queryParams: {'include': 'reports'},
      ) as ResourceObject);

      return patient;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
