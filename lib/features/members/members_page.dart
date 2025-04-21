import 'package:flutter/material.dart';
import 'member_model.dart';
import 'members_service.dart';

class MiembrosPage extends StatelessWidget {
  final service = MiembrosService();

  Color get primaryColor => Colors.deepOrange; // Color principal para los textos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Miembros',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Negrita
          ),
        ),
        backgroundColor: Colors.deepOrange.withOpacity(0.95),
        elevation: 10,
        shadowColor: Colors.deepOrangeAccent,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Container(
        color: Colors.white, // Fondo blanco
        child: FutureBuilder<List<Miembro>>(
          future: service.fetchMiembros(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 50, bottom: 30), // Ajustar padding
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final miembro = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white, // Fondo de la tarjeta blanco
                      shadowColor: Colors.deepOrange.withOpacity(0.3),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100), // Imagen redonda más grande
                              child: Image.network(
                                miembro.foto,
                                width: 80.0, // Tamaño de la imagen más grande
                                height: 80.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    miembro.nombre,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor, // Color del nombre
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    miembro.cargo,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black87,
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
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
