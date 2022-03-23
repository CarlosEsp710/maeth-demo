import 'package:laravel_json_api/laravel_json_api.dart';

class User extends Schema {
  // Constructors
  User(ResourceObject resourceObject) : super(resourceObject);
  User.init(String type) : super.init(type);

  /// Attributes

  String get firstName => getAttribute<String>('first_name');
  set firstName(String value) => setAttribute<String>('first_name', value);

  String get lastName => getAttribute<String>('last_name');
  set lastName(String value) => setAttribute<String>('last_name', value);

  String get email => getAttribute<String>('email');
  set email(String value) => setAttribute<String>('email', value);

  String get imageProfile => getAttribute<String>('image_profile');
  set imageProfile(String value) =>
      setAttribute<String>('image_profile', value);

  String get birthday => getAttribute<String>('birthday');
  set birthday(String value) => setAttribute<String>('birthday', value);

  String get gender => getAttribute<String>('gender');
  set gender(String value) => setAttribute<String>('gender', value);

  String get userType => getAttribute<String>('user_type');
  set userType(String value) => setAttribute<String>('user_type', value);

  String get status => getAttribute<String>('status');
  set status(String value) => setAttribute<String>('status', value);

  String get validation => getAttribute<String>('validation');

  /// Relationships

  // Nutrtionist Profile
  String? get nutritionistProfileId => idFor('nutritionistProfile');

  Map<String, dynamic> get hasNutritionistProfile =>
      dataForHasOne('nutritionistProfile');

  Object? get nutritionistProfile =>
      includedDoc('nutritionists', 'nutritionistProfile');

  // Patient Profile
  String? get patientProfileId => idFor('patientProfile');

  Map<String, dynamic> get hasPatientProfile => dataForHasOne('patientProfile');

  Object? get patientProfile => includedDoc('patients', 'patientProfile');

  // Articles
  Iterable<Object> get articles => includedDocs('articles');
  Iterable<String> get articlesId => idsFor('articles');
}
