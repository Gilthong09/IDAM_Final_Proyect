import 'package:flutter/material.dart';
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
import 'package:final_proyect/features/shelters/shelters_map_page.dart';

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
    SheltersMapPage(),
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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Defensa Civil',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.login, color: Colors.white),
                tooltip: 'Iniciar sesión',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.shield, color: Colors.deepOrange, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menú Principal',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
  title: const Text('Inicio'),
  leading: const Icon(Icons.home, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SliderPage()),
    );
  },
),
ListTile(
  title: const Text('Historia'),
  leading: const Icon(Icons.history, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryPage()),
    );
  },
),

            ListTile(
              title: const Text('Servicios'),
              leading: const Icon(Icons.design_services, color: Colors.deepOrange),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              title: const Text('Noticias'),
              leading: const Icon(Icons.newspaper, color: Colors.deepOrange),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              title: const Text('Videos'),
              leading: const Icon(Icons.video_library, color: Colors.deepOrange),
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              title: const Text('Albergues'),
              leading: const Icon(Icons.location_city, color: Colors.deepOrange),
              onTap: () => _onItemTapped(5),
            ),
            ListTile(
              title: const Text('Mapa'),
              leading: const Icon(Icons.map, color: Colors.deepOrange),
              onTap: () => _onItemTapped(6),
            ),
           ListTile(
  title: const Text('Medidas'),
  leading: const Icon(Icons.shield, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedidasPage()),
    );
  },
),
ListTile(
  title: const Text('Miembros'),
  leading: const Icon(Icons.people, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MiembrosPage()),
    );
  },
),
ListTile(
  title: const Text('Quiero ser voluntario'),
  leading: const Icon(Icons.volunteer_activism, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerFormPage()),
    );
  },
),
ListTile(
  title: const Text('Acerca de'),
  leading: const Icon(Icons.info, color: Colors.deepOrange),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  },
),

          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
