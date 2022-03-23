import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/schemas/category_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

class Article extends Schema {
  // Constructors
  Article(ResourceObject resourceObject) : super(resourceObject);
  Article.init(String type) : super.init(type);

  /// Attributes

  String get title => getAttribute<String>('title');
  set title(String value) => setAttribute<String>('title', value);

  String get slug => getAttribute<String>('slug');
  set slug(String value) => setAttribute<String>('slug', value);

  String get image => getAttribute<String>('image');
  set image(String value) => setAttribute<String>('image', value);

  String get content => getAttribute<String>('content');
  set content(String value) => setAttribute<String>('content', value);

  /// Relationships

  // Author
  String? get authorId => idFor('author');

  Object? get authorDoc => includedDoc('users', 'author');
  set author(User model) => setHasOne('author', model);

  // Category
  String? get categoryId => idFor('author');

  Object? get categoryDoc => includedDoc('categories', 'category');
  set category(Category model) => setHasOne('category', model);
}
