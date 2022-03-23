import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';

class ListCategoriesController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Iterable<Category>> getCategories(BuildContext context) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<Category> categories = (await adapter.findAll('categories'))
          .map<Category>((category) => Category(category as ResourceObject))
          .toList();

      return categories;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Iterable<String>> getCategoriesName(BuildContext context) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<Category> categories = (await adapter.findAll('categories'))
          .map<Category>((category) => Category(category as ResourceObject))
          .toList();

      List<String> categoriesName = ['Seleccionar categoría'];

      for (var category in categories) {
        categoriesName.add(category.name);
      }

      return categoriesName;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
