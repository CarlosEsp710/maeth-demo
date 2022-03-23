import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:maeth_demo/src/controllers/blog/delete_article_controller.dart';
import 'package:maeth_demo/src/controllers/blog/list_article_controller.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/views/blog/edit_article_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis artículos'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(8),
        physics: BouncingScrollPhysics(),
        child: _Articles(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Nuevo artíclo',
        onPressed: () => Navigator.push(
          context,
          PageTransition(
            child: const EditArticleView(),
            type: PageTransitionType.bottomToTop,
          ),
        ),
      ),
    );
  }
}

class _Articles extends StatelessWidget {
  const _Articles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListArticlesController _controller = ListArticlesController();

    return FutureBuilder(
      future: _controller.getMyArticles(context),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? snapshot.data.isEmpty
                ? const Center(
                    child: Text('Aún no haz piblicado nada'),
                  )
                : _articlesList(snapshot, context)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  _articlesList(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    DeleteArticleController _controller = DeleteArticleController();

    List<Article> articles = snapshot.data;

    return (articles.isEmpty)
        ? const Center(child: Text('No tienes ningún artículo'))
        : Column(
            children: articles
                .map((article) => Dismissible(
                      key: Key(article.id.toString()),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (_) =>
                          _controller.deleteArticle(context, article),
                      background: Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      child: ArticleCard(article: article),
                    ))
                .toList(),
          );
  }
}
