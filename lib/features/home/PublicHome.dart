import 'package:flutter/material.dart';
import 'package:final_proyect/shared/constants/app_colors.dart';
import 'package:final_proyect/features/home_slider/slider_page.dart';
import 'package:final_proyect/features/history/history_page.dart';
import 'package:final_proyect/features/about/about_page.dart';
import 'package:final_proyect/features/members/members_page.dart';
import 'package:final_proyect/features/preventive_measures/measures_page.dart';
import 'package:final_proyect/features/volunteers/volunteer_form_page.dart';
import 'package:final_proyect/features/videos/videos_page.dart';
import 'package:final_proyect/features/news/news_page.dart';
import 'package:final_proyect/features/services/service_page.dart';
import 'package:final_proyect/features/shelters/shelters_page.dart';

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SliderPage(),
    HistoryPage(),
    ServicePage(),
    NewsPage(),
    VideosPage(),
    SheltersPage(),
    Center(child: Text('Mapa (próximamente)')),
    MedidasPage(),
    MiembrosPage(),
    VolunteerFormPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Cierra el drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Defensa Civil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Iniciar sesión',
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text(
                'Menú Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.home),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              title: const Text('Historia'),
              leading: const Icon(Icons.history),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              title: const Text('Servicios'),
              leading: const Icon(Icons.design_services),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              title: const Text('Noticias'),
              leading: const Icon(Icons.newspaper),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              title: const Text('Videos'),
              leading: const Icon(Icons.video_library),
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              title: const Text('Albergues'),
              leading: const Icon(Icons.location_city),
              onTap: () => _onItemTapped(5),
            ),
            ListTile(
              title: const Text('Mapa'),
              leading: const Icon(Icons.map),
              onTap: () => _onItemTapped(6),
            ),
            ListTile(
              title: const Text('Medidas Preventivas'),
              leading: const Icon(Icons.shield),
              onTap: () => _onItemTapped(7),
            ),
            ListTile(
              title: const Text('Miembros'),
              leading: const Icon(Icons.people),
              onTap: () => _onItemTapped(8),
            ),
            ListTile(
              title: const Text('Quiero ser voluntario'),
              leading: const Icon(Icons.volunteer_activism),
              onTap: () => _onItemTapped(9),
            ),
            ListTile(
              title: const Text('Acerca de'),
              leading: const Icon(Icons.info),
              onTap: () => _onItemTapped(10),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
