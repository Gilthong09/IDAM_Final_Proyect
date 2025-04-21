import 'package:flutter/material.dart';
import 'service_provider.dart';
import 'service_model.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
        backgroundColor: Colors.orange.shade800,  // Cambié el color de la AppBar
      ),
      body: FutureBuilder<List<Servicio>>(
        future: obtenerServicios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final servicios = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: servicios.length,
            itemBuilder: (context, index) {
              final s = servicios[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 5,  // Mayor elevación para el card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        s.foto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              height: 200,
                              child: Center(child: Icon(Icons.broken_image, size: 50)),
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.nombre,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade800,
                                  fontSize: 22,  // Aumento del tamaño de la fuente para los títulos
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            s.descripcion,
                            style: TextStyle(
                              fontSize: 16,  // Tamaño de la fuente de la descripción
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
