import 'package:laravel_json_api/laravel_json_api.dart';

class Category extends Schema {
  // Constructors
  Category(ResourceObject resourceObject) : super(resourceObject);
  Category.init(String type) : super.init(type);

  /// Attributes

  String get name => getAttribute<String>('name');
  set name(String value) => setAttribute<String>('name', value);

  String get slug => getAttribute<String>('slug');
  set slug(String value) => setAttribute<String>('slug', value);

  String get image => getAttribute<String>('image');
  set image(String value) => setAttribute<String>('image', value);

  /// Relationships

  // Articles
  Iterable<Object> get articles => includedDocs('articles');
}
