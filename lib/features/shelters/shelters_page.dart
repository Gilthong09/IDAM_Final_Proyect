import 'package:flutter/material.dart';
import 'shelter_service.dart';
import 'shelter_model.dart';

class SheltersPage extends StatefulWidget {
  const SheltersPage({super.key});

  @override
  State<SheltersPage> createState() => _SheltersPageState();
}

class _SheltersPageState extends State<SheltersPage> {
  List<Shelter> _allShelters = [];
  List<Shelter> _filteredShelters = [];
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
        _allShelters = shelters;
        _filteredShelters = shelters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterShelters(String query) {
    final filtered =
        _allShelters.where((shelter) {
          final edificioMatch = shelter.edificio.toLowerCase().contains(
            query.toLowerCase(),
          );
          final ciudadMatch = shelter.ciudad.toLowerCase().contains(
            query.toLowerCase(),
          );
          return edificioMatch || ciudadMatch;
        }).toList();

    setState(() {
      _filteredShelters = filtered;
    });
  }

  void _showShelterDetails(Shelter shelter) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(shelter.edificio),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Código: ${shelter.codigo}'),
                Text('Provincia: ${shelter.ciudad}'),
                Text('Coordinador: ${shelter.coordinador}'),
                Text('Teléfono: ${shelter.telefono}'),
                Text(
                  'Capacidad: ${shelter.capacidad.isNotEmpty ? shelter.capacidad : "No especificada"}',
                ),
                Text('Latitud: ${shelter.lat}'),
                Text('Longitud: ${shelter.lng}'),
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
      appBar: AppBar(title: const Text('Albergues')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Error: $_error'))
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Buscar albergue...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _filterShelters,
                    ),
                  ),
                  Expanded(
                    child:
                        _filteredShelters.isEmpty
                            ? const Center(
                              child: Text('No se encontraron albergues'),
                            )
                            : ListView.builder(
                              itemCount: _filteredShelters.length,
                              itemBuilder: (context, index) {
                                final shelter = _filteredShelters[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: ListTile(
                                    title: Text(shelter.edificio),
                                    subtitle: Text(
                                      '${shelter.ciudad} • ${shelter.telefono}',
                                    ),
                                    onTap: () => _showShelterDetails(shelter),
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
    );
  }
}
