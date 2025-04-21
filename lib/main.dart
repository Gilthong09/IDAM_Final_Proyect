// lib/main.dart
import 'package:flutter/material.dart';
import 'package:final_proyect/features/authentication/login_page.dart';
import 'package:final_proyect/shared/constants/app_colors.dart';
import 'package:final_proyect/shared/widgets/splash_screen.dart';
import 'package:final_proyect/features/home/PublicHome.dart';
import 'package:final_proyect/features/home/private_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_proyect/features/news/private_news_page.dart';
import 'package:final_proyect/features/reports/report_situation_page.dart';
import 'package:final_proyect/features/reports/my_situations_page.dart';
import 'package:final_proyect/features/reports/MapSituationsPage.dart';
import 'package:final_proyect/features/reports/change_password_page.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario antes de usar async en main
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(MyApp(initialRoute: token == null ? '/login' : '/home'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defensa Civil App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/splash': (context) => const SplashScreen(),
        // aquí luego tus compañeros agregan otras rutas
      },
    );
  }
}

/// Página de inicio después del login
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Elimina el token guardado

    // Redirige al login y elimina el historial para que no se pueda volver con el botón atrás
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - Defensa Civil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: const Center(child: Text('Bienvenido a la app')),
    );
  }
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Defensa Civil',
      initialRoute: '/',
      routes: {
        '/': (context) => const PublicHome(), // pantalla inicial
        '/login': (context) => const LoginPage(),
        //'/publicHome': (context) => PublicHome(),
        '/home': (context) => const PrivateHome(), // <-- agrega esta línea
        '/private-news': (context) => const PrivateNewsPage(),
        '/report-situation': (context) => const ReportSituationPage(),
        '/my-situations': (context) => const MySituationsPage(),
        '/situation-map': (context) => const MapSituationsPage(),
        '/change-password': (context) => const ChangePasswordPage(),
      },
    );
    /*return MaterialApp(
      title: 'Defensa Civil App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const PrivateHome() : const PublicHome(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/private_home': (context) => const PrivateHome(),
      },
    );*/
  }
}
