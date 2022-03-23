import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:provider/provider.dart';
import 'package:slugify/slugify.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';

class EditArticleController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final slugController = TextEditingController();
  final contentController = TextEditingController();

  dynamic imageArticle;
  String urlImage = '';

  String categoryName = 'Seleccionar categoría';

  void editArticle(BuildContext context, {Article? article}) async {
    (article == null) ? _create(context) : _update(context, article);
  }

  _error(BuildContext context, String text) {
    showErrorAlert(context, 'Algo salió mal', text);
  }

  _create(BuildContext context) async {
    if (imageArticle == null) {
      showErrorAlert(context, 'Error', 'La imágen del post es obligatoria');
    } else {
      if (formKey.currentState!.validate()) {
        showLoading(context);

        final user = Provider.of<UserProvider>(context, listen: false).user;

        final token = await _credentials.getToken();
        _api.addHeader('Authorization', 'Bearer $token');

        Adapter adapter = _api;

        urlImage = await uploadPhoto(imageArticle, 'articles');

        String categoryId =
            slugify(categoryName, lowercase: true, delimiter: '-');

        Category category = Category(await adapter.find(
          'categories',
          categoryId,
        ) as ResourceObject);

        Article article = Article.init('articles');
        article.title = titleController.text.trim();
        article.slug = slugController.text.trim();
        article.content = contentController.text.trim();
        article.image = urlImage;
        article.author = user;
        article.category = category;

        try {
          Article(await adapter.save('articles', article.resourceObject)
              as ResourceObject);

          Navigator.pop(context);

          showSuccessAlert(context, 'Listo!', 'Artículo editado con éxito');
        } on InvalidRecordException {
          Article tempArticle = article;
          Navigator.pop(context);
          _error(context, tempArticle.errors.first['detail']);
        } catch (e) {
          Navigator.pop(context);
          _error(context, e.toString());
        }
      }
    }
  }

  _update(BuildContext context, Article article) async {
    if (formKey.currentState!.validate()) {
      showLoading(context);

      final user = Provider.of<UserProvider>(context, listen: false).user;

      final token = await _credentials.getToken();
      _api.addHeader('Authorization', 'Bearer $token');

      Adapter adapter = _api;

      if (imageArticle == null) {
        urlImage = article.image;
      } else {
        urlImage = await uploadPhoto(imageArticle, 'articles');
      }

      String categoryId =
          slugify(categoryName, lowercase: true, delimiter: '-');

      Category category = Category(await adapter.find(
        'categories',
        categoryId,
      ) as ResourceObject);

      article.title = titleController.text.trim();
      article.slug = slugController.text.trim();
      article.content = contentController.text.trim();
      article.image = urlImage;
      article.author = user;
      article.category = category;

      try {
        Article(await adapter.save('articles', article.resourceObject)
            as ResourceObject);

        Navigator.pop(context);

        showSuccessAlert(context, 'Listo!', 'Artículo editado con éxito');
      } on InvalidRecordException {
        Article tempArticle = article;
        Navigator.pop(context);
        _error(context, tempArticle.errors.first['detail']);
      } catch (e) {
        Navigator.pop(context);
        _error(context, e.toString());
      }
    }
  }
}
