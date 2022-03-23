part of 'widgets.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User(article.authorDoc as ResourceObject);
    Category category = Category(article.categoryDoc as ResourceObject);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ArticleView(article: article),
          type: PageTransitionType.leftToRight,
        ),
      ),
      child: GFCard(
        margin: const EdgeInsets.only(bottom: 15),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        image: Image.network(
          article.image,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        showImage: true,
        title: GFListTile(
          avatar: GFAvatar(
            backgroundImage: NetworkImage(user.imageProfile),
            size: 20,
          ),
          title: Text(
            article.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          subTitleText: 'Por ${user.firstName} ${user.lastName}',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoría: ${category.name}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 5),
            Text(
              article.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
