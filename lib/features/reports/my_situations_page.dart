import 'dart:convert';
import 'package:flutter/material.dart';
import 'situation_model.dart';
import 'situation_service.dart';
import 'dart:typed_data';
import 'dart:developer' as developer;

class MySituationsPage extends StatefulWidget {
  const MySituationsPage({super.key});

  @override
  State<MySituationsPage> createState() => _MySituationsPageState();
}

class _MySituationsPageState extends State<MySituationsPage> {
  late Future<List<Situation>> futureSituations;

  @override
  void initState() {
    super.initState();
    _loadSituations();
  }

  void _loadSituations() {
    setState(() {
      futureSituations = SituationService.getMySituations();
    });
  }

  Widget _buildBase64Image(String base64String) {
    try {
      String fixedBase64 = base64String.trim();

      // Verificar si tiene prefijo, si no, agregarlo automáticamente
      if (!fixedBase64.startsWith("data:image")) {
        if (fixedBase64.startsWith("/9j")) {
          fixedBase64 = "data:image/jpeg;base64,$fixedBase64";
        } else if (fixedBase64.startsWith("iVBORw")) {
          fixedBase64 = "data:image/png;base64,$fixedBase64";
        } else {
          // Por defecto usar jpeg
          fixedBase64 = "data:image/jpeg;base64,$fixedBase64";
        }
      }

      final encoded = fixedBase64.split(',').last;
      final normalized = base64.normalize(encoded);
      final bytes = base64Decode(normalized);

      return Image.memory(
        bytes,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return const Text("⚠️ Imagen inválida");
    }
  }

  /*Widget _buildBase64Image(String base64String) {
    try {
      print("Base64 recibido (inicio): ${base64String.substring(0, 30)}...");
      developer.log("Longitud del base64: ${base64String.length}");

      String fixedBase64 = base64String.trim();

      if (!fixedBase64.startsWith("data:image")) {
        if (fixedBase64.startsWith("/9j")) {
          fixedBase64 = "data:image/jpeg;base64,$fixedBase64";
        } else if (fixedBase64.startsWith("iVBORw")) {
          fixedBase64 = "data:image/png;base64,$fixedBase64";
        } else {
          fixedBase64 = "data:image/jpeg;base64,$fixedBase64";
        }
      }

      final encoded = fixedBase64.split(',').last;

      //  Imprimir base64 limpio antes de decodificar
      print("Base64 limpio (inicio): ${encoded.substring(0, 30)}...");

      //  Limpieza adicional
      final sanitized = encoded.replaceAll(RegExp(r'[^A-Za-z0-9+/=]'), '');
      final normalized = base64.normalize(sanitized);

      Uint8List bytes = base64Decode(normalized);

      if (bytes.isEmpty) {
        return const Text("⚠️ La imagen está vacía");
      }

      print("Imagen decodificada con ${bytes.length} bytes.");

      final image = Image.memory(
        bytes,
        height: 180,
        width: 180,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Error al cargar la imagen: $error");
          return const Text("⚠️Error al mostrar la imagen");
        },
      );

      return image;
    } catch (e, stack) {
      developer.log(
        "Error al procesar imagen base64",
        error: e,
        stackTrace: stack,
      );
      return const Text("⚠️ Imagen inválida");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Situaciones')),
      body: FutureBuilder<List<Situation>>(
        future: futureSituations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('❌ Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aún no has reportado situaciones.'),
            );
          }

          final situations = snapshot.data!;
          return ListView.builder(
            itemCount: situations.length,
            itemBuilder: (context, index) {
              final s = situations[index];
              final fechaMostrar =
                  s.fecha.trim().isNotEmpty
                      ? s.fecha.split(' ').first
                      : 'Sin fecha';

              return ListTile(
                leading: const Icon(Icons.event_note, color: Colors.red),
                title: Text(s.titulo.isNotEmpty ? s.titulo : 'Sin título'),
                subtitle: Text('🗓️ $fechaMostrar - Estado: pendiente'),
                trailing: const Icon(Icons.arrow_forward_ios),

                onTap: () {
                  // DEBUG prints
                  //print("Base64 inicial: ${s.foto.substring(0, 30)}...");
                  //print("Longitud del base64: ${s.foto.length}");
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          scrollable: true,
                          title: Text(
                            s.titulo.isNotEmpty ? s.titulo : 'Sin título',
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              if (s.foto.isNotEmpty)
                                _buildBase64Image(s.foto)
                              else
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("🖼️ Sin imagen disponible"),
                                ),
                              const SizedBox(height: 10),
                              Text(
                                "🆔 Código: ${s.codigo.isNotEmpty ? s.codigo : 'N/D'}",
                              ),
                              const SizedBox(height: 6),
                              Text("🗓️ Fecha: $fechaMostrar"),
                              const SizedBox(height: 6),
                              const Text("📌 Estado: pendiente"),
                              const SizedBox(height: 6),
                              const Text("💬 Comentario: Sin comentario"),
                              const Divider(height: 20),
                              Text(
                                "📜 Descripción:\n${s.descripcion.isNotEmpty ? s.descripcion : 'Sin descripción'}",
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
