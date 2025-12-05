import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/providers/api_client.dart';
import 'package:trabalho_cuidador/utils/jwt_token.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static final ApiClient _api = ApiClient();

  static Future<void> register(Map<String, dynamic> userData) async {
    final response = await _api.post<Map<String, dynamic>>(
      '/user/register',
      userData,
      (data) => data as Map<String, dynamic>,
    );

    final token = response['token'];
    await JwtToken.saveToken(token);
    _api.setToken(token);
  }

  static Future<User> getProfile() async {
    final response = await _api.get<User>(
      '/user/profile',
      (json) => User.fromJson(json as Map<String, dynamic>),
    );
    return response;
  }

  static Future<void> updateProfile(Map<String, dynamic> userData) async {
    await _api.patch('/user/${userData['id']}', userData);
  }

  static Future<void> exportUsersCSV() async {
    try {
      final apiClient = ApiClient();
      final baseUrl = dotenv.env['API_URL'];
      final token = apiClient.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/user/export'),
        headers: {
          'Content-Type': 'text/csv; charset=utf-8; charset=utf-8',
          'Accept': 'text/csv;',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${directory.path}/usuarios_export_$timestamp.csv');

        await file.writeAsBytes(response.bodyBytes);

        await Share.shareXFiles([
          XFile(file.path),
        ], text: 'Exportação de usuários - CuidaDor');
      } else {
        throw Exception('Erro ao exportar CSV: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao exportar CSV de usuários: $e');
      rethrow;
    }
  }
}
