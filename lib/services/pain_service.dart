import 'package:trabalho_cuidador/providers/api_client.dart';

class PainService {
  static final ApiClient _api = ApiClient();

  static Future<void> registerPain({
    required String painLocale,
    required int painScale,
    required String type,
  }) async {
    String dateTimeEvent = DateTime.now().toIso8601String().split('T')[0];
    Map<String, dynamic> body = {
      "painLocale": painLocale,
      "painScale": painScale,
      "type": type,
      "dateTimeEvent": dateTimeEvent,
    };
    print(body);
    await _api.post('/pain', body, (data) => data);
  }

  static Future<String> getBase64GraphImage({
    int? size,
    String? startDate,
    String? endDate,
  }) async {
    String urlPath = '/pain';
    if (size != null) {
      urlPath += '?size=$size';
    }
    if (startDate != null) {
      urlPath += '${size != null ? '&' : '?'}startDate=$startDate';
    }
    if (endDate != null) {
      urlPath += '&endDate=$endDate';
    }
    return _api.get<String>(urlPath, (data) => data['image']);
  }
}
