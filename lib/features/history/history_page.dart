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
      initialVideoId: 'UenHxG_089g',
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get primaryColor => Colors.deepOrange; // Naranja más vivo
  Color get backgroundGradientStart => Color.fromARGB(255, 255, 255, 255); // fondo cálido
  Color get backgroundGradientEnd => Color(0xFFFFCCBC); // degradado claro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGradientStart,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 8,
        shadowColor: const Color.fromARGB(255, 248, 248, 247),
        title: Text(
          'Historia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundGradientStart, backgroundGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressColors: ProgressBarColors(
                      playedColor: primaryColor,
                      handleColor: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor.withOpacity(0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📜 Historia de la Defensa Civil',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'La Defensa Civil tiene como objetivo proteger a la población en situaciones de emergencia y desastre, organizando recursos y promoviendo la cultura de prevención.\n\n'
                      'Nació como respuesta a necesidades sociales urgentes y ha crecido hasta convertirse en una institución fundamental para la seguridad nacional. Hoy en día, su compromiso sigue siendo clave para la protección de vidas humanas.',
                      style: TextStyle(
                        fontSize: 16.5,
                        height: 1.6,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.shield_moon_outlined, color: primaryColor, size: 26),
                        SizedBox(width: 8),
                        Text(
                          'Protegiendo desde siempre',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepOrange.shade400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
