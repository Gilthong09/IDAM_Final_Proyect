import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_model.dart';
import 'video_service.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final VideoService _videoService = VideoService();
  String? _playingVideoId;
  YoutubePlayerController? _controller;

  void _playVideo(String videoId) {
    if (_playingVideoId == videoId) {
      // Cierra el reproductor si ya estaba abierto
      setState(() {
        _playingVideoId = null;
        _controller?.pause();
        _controller?.dispose();
        _controller = null;
      });
    } else {
      // Reproduce un nuevo video
      setState(() {
        _playingVideoId = videoId;
        _controller?.dispose();
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
              final videoId = video.link; // YA es el ID
              final isPlaying = videoId == _playingVideoId;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://img.youtube.com/vi/$videoId/0.jpg',
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        video.titulo,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                      ),
                      subtitle: Text(video.fecha),
                      onTap: () => _playVideo(videoId),
                    ),
                  ),
                  if (isPlaying && _controller != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: YoutubePlayer(
                        controller: _controller!,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.orange,
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
