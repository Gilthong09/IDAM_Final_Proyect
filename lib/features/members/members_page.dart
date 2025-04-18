import 'package:flutter/material.dart';
import 'member_model.dart';
import 'members_service.dart';

class MiembrosPage extends StatelessWidget {
  final service = MiembrosService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Miembros')),
      body: FutureBuilder<List<Miembro>>(
        future: service.fetchMiembros(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final miembro = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    miembro.foto,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                  title: Text(miembro.nombre),
                  subtitle: Text(miembro.cargo),
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
