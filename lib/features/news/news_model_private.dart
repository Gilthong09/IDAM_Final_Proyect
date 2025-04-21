// lib/features/news/news_item.dart

class NewsItem {
  final String id;
  final String fecha;
  final String titulo;
  final String contenido;
  final String foto;

  NewsItem({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.contenido,
    required this.foto,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      fecha: json['fecha'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      foto: json['foto'],
    );
  }
}
