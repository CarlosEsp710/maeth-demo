import 'package:flutter/material.dart';

import 'package:maeth_demo/src/controllers/blog/list_article_controller.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class ArticlesCategoryView extends StatelessWidget {
  final Category category;

  const ArticlesCategoryView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListArticlesController _controller = ListArticlesController();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: FutureBuilder(
        future: _controller.getArticlesByCategory(context, category.slug),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? !snapshot.data.isEmpty
                  ? _articlesList(snapshot, context)
                  : const Center(
                      child: Text('No hay artículos en esta categoría'),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  _articlesList(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    List<Article> articles = snapshot.data;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Column(
        children:
            articles.map((article) => ArticleCard(article: article)).toList(),
      ),
    );
  }
}
