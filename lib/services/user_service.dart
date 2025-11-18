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
    await JwtToken.saveToken(response['token']);
  }

  static Future<User> getProfile() async {
    final response = await _api.get<User>(
      '/user/profile',
      (json) => User.fromJson(json as Map<String, dynamic>),
    );
    return response;
  }
}
