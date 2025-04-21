import 'dart:convert';
import 'package:http/http.dart' as http;
import 'shelter_model.dart';

class ShelterService {
  static Future<List<Shelter>> fetchShelters() async {
    final response = await http.get(
      Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List shelters = data['datos'];
      return shelters.map((json) => Shelter.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los albergues');
    }
  }
}
