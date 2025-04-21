class Situation {
  final String codigo;
  final String fecha;
  final String titulo;
  final String descripcion;
  final String foto;
  final String estado;
  final String comentario;
  final String latitud;
  final String longitud;

  Situation({
    required this.codigo,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.estado,
    required this.comentario,
    required this.latitud,
    required this.longitud,
  });

  factory Situation.fromJson(Map<String, dynamic> json) {
    final fechaRaw = json['fecha_creacion'];
    return Situation(
      codigo: json['id']?.toString() ?? '',
      fecha:
          fechaRaw?.toString().trim().isNotEmpty == true
              ? fechaRaw.toString().trim()
              : DateTime.now().toString(),
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
      estado: 'pendiente',
      comentario: 'Sin comentario',
      latitud: json['latitud']?.toString() ?? '',
      longitud: json['longitud']?.toString() ?? '',
    );
  }
}
