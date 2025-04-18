import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'UenHxG_089g', // Reemplaza con el ID del video real
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historia')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              SizedBox(height: 20),
              Text(
                'Historia de la Defensa Civil',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'La Defensa Civil tiene como objetivo proteger a la población en situaciones de emergencia y desastre, organizando recursos y promoviendo la cultura de prevención. Nació como respuesta a necesidades sociales urgentes y ha crecido hasta convertirse en una institución fundamental para la seguridad nacional...',
                style: TextStyle(fontSize: 16),
              ),
              // Puedes seguir agregando más texto aquí
            ],
          ),
        ),
      ),
    );
  }
}
