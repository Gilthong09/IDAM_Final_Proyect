import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'situation_model.dart';

class SituationService {
  static Future<List<Situation>> getMySituations() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no disponible');

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
      body: {'token': token},
    );

    final data = jsonDecode(response.body);

    print("🚀 Datos de la API:");
    print(data);

    if (data['exito'] == true) {
      final list = data['datos'] as List;
      return list.map((e) => Situation.fromJson(e)).toList();
    } else {
      throw Exception(data['mensaje']);
    }
  }
}
