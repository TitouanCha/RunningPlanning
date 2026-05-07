import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'token';
  static const _userId = 'userId';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userId, value: userId);
  }

  Future<String> getToken() async {
    return await _storage.read(key: _tokenKey) ?? "";
  }

  Future<String> getUserId() async {
    return await _storage.read(key: _userId) ?? "";
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}