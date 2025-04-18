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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Acerca de los desarrolladores'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: developers.length,
        itemBuilder: (context, index) {
          final dev = developers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(dev['image']!),
                      radius: 35,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dev['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => _launchURL('tel:${dev['phone']}'),
                            child: Row(
                              children: [
                                const Icon(Icons.phone, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(
                                  dev['phone']!,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () => _launchURL(dev['telegram']!),
                            child: Row(
                              children: [
                                const Icon(Icons.telegram, color: Colors.blue),
                                const SizedBox(width: 8),
                                const Text(
                                  'Telegram',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
