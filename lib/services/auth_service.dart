// services/auth_service.dart
class AuthService {
  static bool _loggedIn = false;

  static Future<bool> isUserLoggedIn() async {
    // aqui tu poderia checar token no storage, por exemplo
    return _loggedIn;
  }

  static Future<void> login(String user, String pass) async {
    // valida usuário e senha via API, etc.
    _loggedIn = true;
  }

  static Future<void> logout() async {
    _loggedIn = false;
  }
}
