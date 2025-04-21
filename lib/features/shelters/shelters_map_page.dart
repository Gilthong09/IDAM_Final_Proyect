import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'shelter_model.dart';
import 'shelter_service.dart';

class SheltersMapPage extends StatefulWidget {
  const SheltersMapPage({super.key});

  @override
  State<SheltersMapPage> createState() => _SheltersMapPageState();
}

class _SheltersMapPageState extends State<SheltersMapPage> {
  List<Shelter> _shelters = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadShelters();
  }

  Future<void> _loadShelters() async {
    try {
      final shelters = await ShelterService.fetchShelters();
      setState(() {
        _shelters = shelters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showDetailsDialog(Shelter shelter) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(shelter.edificio),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Código: ${shelter.codigo}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_city, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Ciudad: ${shelter.ciudad}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.person, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Coordinador: ${shelter.coordinador}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Teléfono: ${shelter.telefono}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.group, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text(
                  'Capacidad: ${shelter.capacidad.isNotEmpty ? shelter.capacidad : "No especificada"}',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Latitud: ${shelter.lat}'), // lat = longitud real
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Longitud: ${shelter.lng}'), // lng = latitud real
              ],
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Albergues')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : FlutterMap(
                  options: MapOptions(
                    center: LatLng(18.5, -69.9), // centro de RD
                    zoom: 8.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: _shelters
                          .map((shelter) {
                            final latitude = double.tryParse(shelter.lat); // lat = longitud real
                            final longitude = double.tryParse(shelter.lng); // lng = latitud real
                            if (latitude == null || longitude == null) return null;
                            return Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(latitude, longitude),
                              child: GestureDetector(
                                onTap: () => _showDetailsDialog(shelter),
                                child: const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          })
                          .whereType<Marker>()
                          .toList(), // Filtramos nulos
                    ),
                  ],
                ),
    );
  }
}
