import 'dart:convert';
import 'package:http/http.dart' as http;
import 'video_model.dart';

class VideoService {
  final String _url = 'https://adamix.net/defensa_civil/def/videos.php';

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['exito']) {
        return (data['datos'] as List)
            .map((item) => Video.fromJson(item))
            .toList();
      }
    }
    throw Exception('Error al cargar los videos');
  }
}
