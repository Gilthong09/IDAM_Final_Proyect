import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  final String _url = 'https://adamix.net/defensa_civil/def/noticias.php';

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['exito']) {
        return (data['datos'] as List)
            .map((item) => News.fromJson(item))
            .toList();
      }
    }
    throw Exception('Error al cargar las noticias');
  }
}
