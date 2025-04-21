import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'video_model.dart';
import 'video_service.dart';

class VideosPage extends StatelessWidget {
  final VideoService _videoService = VideoService();

  Future<void> _openVideo(String videoId) async {
    final url = 'https://www.youtube.com/watch?v=$videoId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el video: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Videos')),
      body: FutureBuilder<List<Video>>(
        future: _videoService.fetchVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('No hay videos disponibles'));

          final videos = snapshot.data!;
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://img.youtube.com/vi/${video.link}/0.jpg',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    video.titulo,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                  ),
                  subtitle: Text(video.fecha),
                  onTap: () => _openVideo(video.link),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
