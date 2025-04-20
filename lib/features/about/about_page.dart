import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final List<Map<String, String>> developers = [
    {
      'name': 'Gilthong Palin',
      'phone': '+34611949632',
      'telegram': 'https://t.me/Gilthong',
      'image': 'assets/about/Gilthong.jpg',
    },
    {
      'name': 'Eimi Rosalia',
      'phone': '+18098863715',
      'telegram': 'https://t.me/eimirosalia',
      'image': 'assets/about/Eimi.jpg',
    },
    {
      'name': 'Enmanuel Lopéz',
      'phone': '+18494044912',
      'telegram': 'https://t.me/EnmanuelLopez12',
      'image': 'assets/about/Enmanuel.jpg',
    },
    {
      'name': 'Juan Rosario',
      'phone': '+18099876543',
      'telegram': 'https://t.me/JERB24',
      'image': 'assets/about/Juan.jpg',
    },
    {
      'name': 'Diorkys Cabrera',
      'phone': '+18494489562',
      'telegram': 'https://t.me/diorkyscabrefa',
      'image': 'assets/about/Diorkys.jpg',
    },
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Desarrolladores',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 10,
        shadowColor: Colors.deepOrangeAccent,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Fondo blanco elegante
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 100, bottom: 30),
          itemCount: developers.length,
          itemBuilder: (context, index) {
            final dev = developers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                splashColor: Colors.orange.withOpacity(0.2),
                onTap: () {}, // Opcional: alguna acción al presionar la tarjeta
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.orange.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrange.withOpacity(0.15),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: Colors.deepOrange.shade100, width: 1.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(dev['image']!),
                          radius: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dev['name']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFBF360C), // Naranja profundo
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.phone, color: Colors.green, size: 20),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () => _launchURL('tel:${dev['phone']}'),
                                    child: Text(
                                      dev['phone']!,
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.telegram, color: Colors.blue, size: 20),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () => _launchURL(dev['telegram']!),
                                    child: const Text(
                                      'Telegram',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
