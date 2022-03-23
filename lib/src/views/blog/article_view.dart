import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:maeth_demo/src/views/blog/edit_article_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<UserProvider>(context, listen: false).user;

    User user = User(article.authorDoc as ResourceObject);
    Category category = Category(article.categoryDoc as ResourceObject);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            GFImageOverlay(
              height: 250,
              width: double.infinity,
              image: NetworkImage(article.image),
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              article.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 2,
              color: Color(0xff87D2B1),
            ),
            const SizedBox(height: 5),
            Text(
              article.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 1,
              color: Color(0xff87D2B1),
            ),
            const SizedBox(height: 5),
            GFListTile(
              avatar: GFAvatar(
                backgroundImage: NetworkImage(user.imageProfile),
                size: 20,
              ),
              titleText: 'Por: ${user.firstName} ${user.lastName}',
              subTitleText:
                  (user.userType == 'Nutriólogo') ? 'Nutriólogo' : null,
            ),
          ],
        ),
      ),
      floatingActionButton: (user == me)
          ? FloatingActionButton(
              child: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                PageTransition(
                  child: EditArticleView(article: article),
                  type: PageTransitionType.topToBottom,
                ),
              ),
            )
          : null,
    );
  }
}
