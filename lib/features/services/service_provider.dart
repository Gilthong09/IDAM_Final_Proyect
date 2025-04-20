import 'dart:convert';
import 'package:http/http.dart' as http;
import 'service_model.dart';

Future<List<Servicio>> obtenerServicios() async {
  final url = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['exito']) {
      List serviciosJson = jsonData['datos'];
      return serviciosJson.map((e) => Servicio.fromJson(e)).toList();
    }
  }
  throw Exception('Error al obtener los servicios');
}
