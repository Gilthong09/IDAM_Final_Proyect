import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/constants/api_constants.dart';

class ReportService {
  static Future<Map<String, dynamic>> reportSituation({
    required String titulo,
    required String descripcion,
    required String fotoBase64,
    required String latitud,
    required String longitud,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no encontrado');

    final response = await http.post(
      Uri.parse(ApiConstants.reportSituation),
      body: {
        'titulo': titulo,
        'descripcion': descripcion,
        'foto': fotoBase64,
        'latitud': latitud,
        'longitud': longitud,
        'token': token,
      },
    );

    print(response);

    final data = jsonDecode(response.body);
    return data;
  }
}
