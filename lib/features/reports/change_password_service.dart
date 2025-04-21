import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordService {
  static Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no encontrado');

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php'),
      body: {
        'token': token,
        'clave_anterior': oldPassword,
        'clave_nueva': newPassword,
      },
    );

    final data = jsonDecode(response.body);
    return data;
  }
}
