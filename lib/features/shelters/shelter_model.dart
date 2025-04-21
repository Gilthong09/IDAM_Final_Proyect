class Shelter {
  final String codigo;
  final String edificio;
  final String ciudad;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final String lat;
  final String lng;

  Shelter({
    required this.codigo,
    required this.edificio,
    required this.ciudad,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      codigo: json['codigo'] ?? '',
      edificio: json['edificio'] ?? '',
      ciudad: json['ciudad'] ?? '',
      coordinador: json['coordinador'] ?? '',
      telefono: json['telefono'] ?? '',
      capacidad: json['capacidad'] ?? '',
      lat: json['lat'] ?? '',
      lng: json['lng'] ?? '',
    );
  }
}
