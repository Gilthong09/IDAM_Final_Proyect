import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../shared/constants/api_constants.dart';

class VolunteerService {
  static Future<bool> registerVolunteer({
    required String cedula,
    required String nombre,
    required String apellido,
    required String correo,
    required String telefono,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(ApiConstants.volunteerApplication),
      //headers: {'Content-Type': 'application/json'},
      body: ({
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'telefono': telefono,
        'clave': password,
      }),
    );
    print("cedula: $cedula");
    print("nombre: $nombre");
    print('Código de estado: ${response.statusCode}');
    print('Respuesta: ${response.body}');

    /*final url = Uri.parse(ApiConstants.loginApp);
    final response = await http.post(
      url,
      body: {'cedula': cedula, 'clave': clave},
    );*/

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return body['exito'] == true;
    }

    return false;
  }
}
