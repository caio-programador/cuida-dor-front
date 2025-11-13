import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtToken {
  static const storage = FlutterSecureStorage();
  static const String _key = 'jwt_token';

  static Future<void> saveToken(String token) async {
    await storage.write(key: _key, value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: _key);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: _key);
  }
}
