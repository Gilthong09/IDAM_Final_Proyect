import 'package:flutter/material.dart';
import 'measures_service.dart';
import 'measure_model.dart';

class MedidasPage extends StatelessWidget {
  final service = MedidasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medidas Preventivas')),
      body: FutureBuilder<List<MedidaPreventiva>>(
        future: service.fetchMedidas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final medida = snapshot.data![index];
                return ListTile(
                  title: Text(medida.titulo),
                  leading: Image.network(
                    medida.foto,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalleMedidaPage(medida: medida),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DetalleMedidaPage extends StatelessWidget {
  final MedidaPreventiva medida;

  DetalleMedidaPage({required this.medida});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(medida.titulo)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(medida.descripcion),
      ),
    );
  }
}
