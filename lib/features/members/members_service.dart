import 'dart:convert';
import 'member_model.dart';
import 'package:http/http.dart' as http;
import '../../shared/constants/api_constants.dart';

class MiembrosService {
  Future<List<Miembro>> fetchMiembros() async {
    final response = await http.get(Uri.parse(ApiConstants.members));
    if (response.statusCode == 200) {
      final List datos = json.decode(response.body)['datos'];
      return datos.map((e) => Miembro.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar los miembros');
    }
  }
}
