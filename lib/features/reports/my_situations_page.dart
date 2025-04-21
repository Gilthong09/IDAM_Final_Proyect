import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<File?> _getLocalImageFile(String codigo) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/imagen_$codigo.jpg';
      final file = File(path);
      return file.existsSync() ? file : null;
    } catch (e) {
      return null;
    }
  }

  Widget _buildImageWidget(Situation s) {
    return FutureBuilder<File?>(
      future: _getLocalImageFile(s.codigo),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final file = snapshot.data;
        if (file != null && file.existsSync()) {
          return Image.file(
            file,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("🖼️ Imagen no disponible"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 8,
        shadowColor: const Color.fromARGB(255, 248, 248, 247),
        title: const Text(
          'Mis Situaciones',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
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

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.event_note, color: Colors.red),
                  title: Text(s.titulo.isNotEmpty ? s.titulo : 'Sin título'),
                  subtitle: Text('🗓️ $fechaMostrar - Estado: pendiente'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
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
                                _buildImageWidget(s),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
