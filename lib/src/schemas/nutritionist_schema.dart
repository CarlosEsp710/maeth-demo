import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/schemas/user_schema.dart';

class Nutritionist extends Schema {
  /// Constructors
  Nutritionist(ResourceObject resourceObject) : super(resourceObject);
  Nutritionist.init(String type) : super.init(type);

  /// Attributes

  String get phoneNumber => getAttribute<String>('phone_number');
  set phoneNumber(String value) => setAttribute<String>('phone_number', value);

  String get address => getAttribute<String>('address');
  set address(String value) => setAttribute<String>('address', value);

  String get description => getAttribute<String>('description');
  set description(String value) => setAttribute<String>('description', value);

  String get curriculum => getAttribute<String>('curriculum');
  set curriculum(String value) => setAttribute<String>('curriculum', value);

  String get identificationCard => getAttribute<String>('identification_card');
  set identificationCard(String value) =>
      setAttribute<String>('identification_card', value);

  List<String> get specializations =>
      getAttribute<List<String>>('specializations');
  set specializations(List<String> values) =>
      setAttribute<List<String>>('specializations', values);

  /// Errors

  /// Relationships
  String? get userId => idFor('user');
  set user(User model) => setHasOne('user', model);

  Iterable<Object> get patients => includedDocs('patients');
  Iterable<String> get patientsId => idsFor('patients');
}
