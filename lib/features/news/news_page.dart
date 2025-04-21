import 'package:flutter/material.dart';
import 'news_service.dart';
import 'news_model.dart';

class NewsPage extends StatelessWidget {
  final NewsService _newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noticias')),
      body: FutureBuilder<List<News>>(
        future: _newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('No hay noticias disponibles'));

          final noticias = snapshot.data!;
          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      noticia.foto,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    noticia.titulo,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                  ),
                  subtitle: Text(noticia.fecha),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        title: Text(noticia.titulo, style: TextStyle(color: Colors.orange.shade800)),
                        content: SingleChildScrollView(child: Text(noticia.contenido)),
                        actions: [
                          TextButton(
                            child: const Text("Cerrar"),
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
