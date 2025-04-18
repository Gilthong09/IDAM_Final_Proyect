import 'package:flutter/material.dart';
import 'package:final_proyect/shared/constants/app_colors.dart';
import 'package:final_proyect/features/home_slider/slider_page.dart';
import 'package:final_proyect/features/history/history_page.dart';
import 'package:final_proyect/features/about/about_page.dart';

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    Center(child: Text('Inicio (Slider)')),
    Center(child: Text('Historia')),
    Center(child: Text('Servicios')),
    Center(child: Text('Noticias')),
    Center(child: Text('Videos')),
    Center(child: Text('Albergues')),
    Center(child: Text('Mapa')),
    Center(child: Text('Medidas Preventivas')),
    Center(child: Text('Miembros')),
    Center(child: Text('Quiero ser voluntario')),
    Center(child: Text('Acerca de')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SliderPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Historia'),
              leading: const Icon(Icons.history),
              //onTap: () => HistoryPage(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
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
              //onTap: () => AboutPage(),
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
