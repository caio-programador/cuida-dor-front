import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static final String? baseUrl = dotenv.env['API_URL'];

  final http.Client _client = http.Client();

  static String? _token;

  void setToken(String? token) {
    _token = token;
  }

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  Future<T> get<T>(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return fromJson(data);
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<T> post<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(dynamic) fromJson,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return fromJson(data);
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}

class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException({this.statusCode, required this.message});
}
