import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  final String id;
  final String fecha;
  final String titulo;
  final String descripcion;
  final String link;

  Video({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.link,
  });

  String get videoId => YoutubePlayer.convertUrlToId(link) ?? link;

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      fecha: json['fecha'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      link: json['link'],
    );
  }
}
