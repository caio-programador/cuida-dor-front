import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/providers/api_client.dart';
import 'package:trabalho_cuidador/utils/jwt_token.dart';

class UserService {
  static final ApiClient _api = ApiClient();

  static Future<void> register(Map<String, dynamic> userData) async {
    final response = await _api.post<Map<String, dynamic>>(
      '/user/register',
      userData,
      (data) => data as Map<String, dynamic>,
    );

    _api.setToken(response['token']);
    await JwtToken.saveToken(response['token']);
  }

  Future<User> getProfile() async {
    return await _api.get<User>(
      '/user/profile',
      (json) => User.fromJson(json as Map<String, dynamic>),
    );
  }
}
