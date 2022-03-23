import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialsController {
  final _storage = const FlutterSecureStorage();

  Future saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future getToken() async {
    return await _storage.read(key: 'token');
  }

  Future deleteToken() async {
    return await _storage.delete(key: 'token');
  }

  Future saveUserId(String id) async {
    return await _storage.write(key: 'userId', value: id);
  }

  Future getUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future deleteUserId() async {
    return await _storage.delete(key: 'userId');
  }

  Future saveProfileId(String profileId) async {
    return await _storage.write(key: 'profileId', value: profileId);
  }

  Future getProfileId() async {
    return await _storage.read(key: 'profileId');
  }

  Future deleteProfileId() async {
    return await _storage.delete(key: 'profileId');
  }

  Future saveNutritionistId(String nutritionistId) async {
    return await _storage.write(key: 'nutritionistId', value: nutritionistId);
  }

  Future getNutritionistId() async {
    return await _storage.read(key: 'nutritionistId');
  }

  Future deleteNutritionistId() async {
    return await _storage.delete(key: 'nutritionistId');
  }
}
