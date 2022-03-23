import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';
import 'package:provider/provider.dart';

class ListArticlesController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  Future<Iterable<Article>> getArticles(BuildContext context) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<Article> articles = (await adapter
              .findAll('articles', queryParams: {'include': 'category,author'}))
          .map<Article>((article) => Article(article as ResourceObject))
          .toList();

      return articles;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Iterable<Article>> getMyArticles(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<String> ids = userProvider.user.articlesId;

      Iterable<Article> articles = (await adapter.findManyById('articles', ids,
              queryParams: {'include': 'author,category'}))
          .map<Article>((article) => Article(article as ResourceObject))
          .toList();

      return articles;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Iterable<Article>> getArticlesByCategory(
      BuildContext context, String category) async {
    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;

    try {
      Iterable<String> categories = category.split(',');

      Iterable<Article> articles = (await adapter.filter(
              'articles', 'category', categories,
              queryParams: {'include': 'category,author'}))
          .map<Article>((article) => Article(article as ResourceObject))
          .toList();

      return articles;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
