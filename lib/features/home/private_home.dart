import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivateHome extends StatelessWidget {
  const PrivateHome({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Voluntario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => logout(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                'Menú del Voluntario',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                Navigator.pushNamed(context, '/private-news');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('Reportar Situación'),
              onTap: () {
                Navigator.pushNamed(context, '/report-situation');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Mis Situaciones'),
              onTap: () {
                Navigator.pushNamed(context, '/my-situations');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa de Situaciones'),
              onTap: () {
                Navigator.pushNamed(context, '/situation-map');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text('Cambiar Contraseña'),
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bienvenido al panel de voluntario',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
