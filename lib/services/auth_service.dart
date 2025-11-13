// services/auth_service.dart
import 'package:trabalho_cuidador/providers/api_client.dart';
import 'package:trabalho_cuidador/utils/jwt_token.dart';

class AuthService {
  static bool _loggedIn = false;
  static final ApiClient _api = ApiClient();

  static Future<bool> isUserLoggedIn() async {
    String? token = await JwtToken.getToken();
    if (token != null) {
      _loggedIn = true;
    } else {
      _loggedIn = false;
    }
    return _loggedIn;
  }

  static Future<void> login(String user, String pass) async {
    final response = await _api.post<Map<String, dynamic>>('/auth/login', {
      'email': user,
      'password': pass,
    }, (data) => data as Map<String, dynamic>);
    _api.setToken(response['token']);
    await JwtToken.saveToken(response['token']);
    _loggedIn = true;
  }

  static Future<void> logout() async {
    await JwtToken.deleteToken();
    _api.setToken(null);
    _loggedIn = false;
  }
}
