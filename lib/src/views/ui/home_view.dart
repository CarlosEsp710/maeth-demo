import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maeth_demo/src/views/blog/articles_category_view.dart';
import 'package:page_transition/page_transition.dart';

import 'package:maeth_demo/src/controllers/blog/list_article_controller.dart';
import 'package:maeth_demo/src/controllers/blog/list_category_controller.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';
import 'package:maeth_demo/src/views/blog/article_view.dart';
import 'package:maeth_demo/src/views/blog/articles_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maeth'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Bienvenido a Maeth, descubre y comparte información nutricional dentro de nuestra comunidad.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Categorías',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              _BlogCategories(),
              SizedBox(height: 15),
              Text(
                'Artículos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 15),
              _BlogArticles(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: const Icon(Icons.list_alt_outlined),
        tooltip: 'Mis artículos',
        onPressed: () => Navigator.push(
          context,
          PageTransition(
            child: const ArticlesView(),
            type: PageTransitionType.bottomToTop,
          ),
        ),
      ),
    );
  }
}

class _BlogCategories extends StatelessWidget {
  const _BlogCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListCategoriesController _controller = ListCategoriesController();

    return FutureBuilder(
      future: _controller.getCategories(context),
      builder: (context, AsyncSnapshot snapshot) {
        return (snapshot.hasData)
            ? _categoryList(snapshot, context)
            : _categorySkelton();
      },
    );
  }

  _categoryList(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) => _categoryChip(
          context,
          snapshot.data![index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  _categoryChip(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ArticlesCategoryView(category: category),
          type: PageTransitionType.rightToLeft,
        ),
      ),
      child: Chip(
        label: Text(
          category.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors
            .primaries[Random().nextInt(Colors.primaries.length)]
            .withOpacity(0.8),
        elevation: 1,
      ),
    );
  }

  _categorySkelton() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) => const Skeleton(height: 7, width: 70),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}

class _BlogArticles extends StatelessWidget {
  const _BlogArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListArticlesController _controller = ListArticlesController();

    return FutureBuilder(
      future: _controller.getArticles(context),
      builder: (context, AsyncSnapshot snapshot) {
        return (snapshot.hasData)
            ? _articleList(snapshot, context)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  _articleList(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    List<Article> articles = snapshot.data;

    return Column(
      children: articles
          .map((article) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: ArticleView(article: article),
                    type: PageTransitionType.rightToLeft,
                  ),
                ),
                child: ArticleCard(article: article),
              ))
          .toList(),
    );
  }
}
