import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  static Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://adamix.net/defensa_civil/def/noticias.php'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List noticias = data['datos'];
      return noticias.map((item) => NewsItem.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar noticias');
    }
  }
}
