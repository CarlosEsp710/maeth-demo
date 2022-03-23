import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/schemas/report_schema.dart';

class ListReportController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Iterable<Report>> getReports(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Patient patient = Patient(await adapter.find(
        'patients',
        user.patientProfileId!,
        queryParams: {'include': 'reports'},
      ) as ResourceObject);

      Iterable<Report> reports = patient.reports
          .map<Report>((report) => Report(report as ResourceObject))
          .toList();

      return reports;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
