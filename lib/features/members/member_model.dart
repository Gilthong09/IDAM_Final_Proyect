class Miembro {
  final String nombre;
  final String cargo;
  final String foto;

  Miembro({required this.nombre, required this.cargo, required this.foto});

  factory Miembro.fromJson(Map<String, dynamic> json) {
    return Miembro(
      nombre: json['nombre'],
      cargo: json['cargo'],
      foto: json['foto'],
    );
  }
}
