import 'package:http/http.dart' as http;
import 'dart:convert';
import 'measure_model.dart';
import '../../shared/constants/api_constants.dart';

class MedidasService {
  Future<List<MedidaPreventiva>> fetchMedidas() async {
    final response = await http.get(Uri.parse(ApiConstants.preventiveMeasures));

    if (response.statusCode == 200) {
      final List datos = json.decode(response.body)['datos'];
      return datos.map((e) => MedidaPreventiva.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las medidas');
    }
  }
}
