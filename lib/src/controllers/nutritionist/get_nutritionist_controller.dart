import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/schemas/nutritionist_schema.dart';

class GetNutritionistController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Nutritionist?> getNutritionist(
      BuildContext context, String? id) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Nutritionist nutritionist = Nutritionist(await adapter.find(
        'nutritionists',
        id ?? await _credentials.getNutritionistId(),
        queryParams: {'include': 'patients'},
      ) as ResourceObject);

      return nutritionist;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
