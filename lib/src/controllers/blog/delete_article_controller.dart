import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';

class DeleteArticleController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  void deleteArticle(BuildContext context, Article article) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      await adapter.delete('articles', article.resourceObject);

      showSuccessAlert(
        context,
        'Listo',
        'Artículo eliminado con éxito',
      );
    } catch (e) {
      print(e);
    }
  }
}
