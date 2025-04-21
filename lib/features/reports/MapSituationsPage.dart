// map_situations_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'situation_service.dart';
import 'situation_model.dart';

class MapSituationsPage extends StatefulWidget {
  const MapSituationsPage({super.key});

  @override
  State<MapSituationsPage> createState() => _MapSituationsPageState();
}

class _MapSituationsPageState extends State<MapSituationsPage> {
  late Future<List<Situation>> futureSituations;

  @override
  void initState() {
    super.initState();
    futureSituations = SituationService.getMySituations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa de Situaciones")),
      body: FutureBuilder<List<Situation>>(
        future: futureSituations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("❌ Error: \${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay situaciones reportadas."));
          }

          final situations = snapshot.data!;

          final markers =
              situations
                  .where((s) => s.latitud.isNotEmpty && s.longitud.isNotEmpty)
                  .map((s) {
                    double? lat = double.tryParse(s.latitud);
                    double? lng = double.tryParse(s.longitud);

                    if (lat == null || lng == null) return null;

                    return Marker(
                      point: LatLng(lat, lng),
                      width: 60,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: Text(s.titulo),
                                  content: Text(s.descripcion),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cerrar"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                          );
                        },
                        child: const Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    );
                  })
                  .whereType<Marker>()
                  .toList();

          return FlutterMap(
            options: MapOptions(
              center:
                  markers.isNotEmpty
                      ? markers.first.point
                      : LatLng(18.5, -69.9),
              zoom: 8.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
            ],
          );
        },
      ),
    );
  }
}
