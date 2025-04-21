import 'package:flutter/material.dart';
import 'news_service.dart';
import 'news_model.dart';

class NewsPage extends StatelessWidget {
  final NewsService _newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noticias',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange, // Color vibrante
        elevation: 8,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: FutureBuilder<List<News>>(
        future: _newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
            );
          else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('No hay noticias disponibles', style: TextStyle(fontSize: 18, color: Colors.grey)));

          final noticias = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                color: Colors.orange.shade50, // Fondo claro para la tarjeta
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      noticia.foto,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    noticia.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepOrange.shade700,
                    ),
                  ),
                  subtitle: Text(
                    noticia.fecha,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        title: Text(
                          noticia.titulo,
                          style: TextStyle(color: Colors.deepOrange.shade800, fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          child: Text(noticia.contenido, style: TextStyle(fontSize: 16, color: Colors.black87)),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cerrar", style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () => Navigator.pop(context),
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
