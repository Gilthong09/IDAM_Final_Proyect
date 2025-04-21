import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/constants/api_constants.dart';

class AuthService {
  static Future<bool> login(String cedula, String clave) async {
    final url = Uri.parse(ApiConstants.loginApp);
    final response = await http.post(
      url,
      body: {'cedula': cedula, 'clave': clave},
    );

    print('Código de estado: ${response.statusCode}');
    print('Respuesta: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['exito'] == true && data['datos'] != null) {
        final token = data['datos']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return true;
      } else {
        return false; // No lanza excepción, retorna false
      }
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }

  static Future<void> recoverPassword(String email, String cedula) async {
    final url = Uri.parse(ApiConstants.forgotPassword);
    final response = await http.post(
      url,
      body: {'correo': email, 'cedula': cedula},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['exito'] != true) {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Error al recuperar contraseña.');
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
