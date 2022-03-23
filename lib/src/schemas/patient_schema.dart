import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/schemas/user_schema.dart';

class Patient extends Schema {
  /// Constructors
  Patient(ResourceObject resourceObject) : super(resourceObject);
  Patient.init(String type) : super.init(type);

  /// Attributes

  String get phoneNumber => getAttribute<String>('phone_number');
  set phoneNumber(String value) => setAttribute<String>('phone_number', value);

  String get address => getAttribute<String>('address');
  set address(String value) => setAttribute<String>('address', value);

  String get description => getAttribute<String>('description');
  set description(String value) => setAttribute<String>('description', value);

  String get scholarship => getAttribute<String>('scholarship');
  set scholarship(String value) => setAttribute<String>('scholarship', value);

  String get occupation => getAttribute<String>('occupation');
  set occupation(String value) => setAttribute<String>('occupation', value);

  double get height => getAttribute<double>('height');
  set height(double value) => setAttribute<double>('height', value);

  double get weight => getAttribute<double>('weight');
  set weight(double value) => setAttribute<double>('weight', value);

  /// Relationships

  String? get userId => idFor('user');
  set user(User model) => setHasOne('user', model);

  // Nutritionist
  String? get nutritionistId => idFor('nutritionist');
  Object? get myNutritionist => includedDoc('users', 'nutritionist');
  set nutritionist(User model) => setHasOne('nutritionist', model);

  // Reports
  Iterable<Object> get reports => includedDocs('reports');
  Iterable<String> get reportsId => idsFor('reports');
}
