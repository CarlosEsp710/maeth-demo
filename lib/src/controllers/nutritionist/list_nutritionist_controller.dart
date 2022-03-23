import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

class ListNutritionistsController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Iterable<User>> listNutritionists(BuildContext context) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<User> nutritionists = (await adapter.filter(
              'users', 'type', ['Nutriólogo'],
              queryParams: {'include': 'nutritionistProfile'}))
          .map<User>((user) => User(user as ResourceObject))
          .toList();

      return nutritionists;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
