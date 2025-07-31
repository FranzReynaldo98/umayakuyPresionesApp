class Vivienda {
  int id;
  String geom;
  String catastro, circuito, nombre;
  double latitud, longitud; 
  Vivienda({
    required this.id, required this.geom, required this.catastro, required this.circuito,
    required this.nombre, required this.latitud, required this.longitud,
  });

  factory Vivienda.fromJSON(Map<String,dynamic> data) => Vivienda(
    id: data['id'] ?? 0, geom: data['geom'] ?? '', catastro: data['catastro'] ?? '', 
    circuito: data['circuito'] ?? '', nombre: data['nombre'] ?? '', 
    latitud: data['lat'] ?? 0.0, longitud: data['lon'] ?? 0.0
  );

  void copyWith ({
    String? geom, String? catastro, String? circuito, String? nombre, 
    double? latitud, double? longitud}) {
    this.geom = geom ?? this.geom;
    this.catastro = catastro ?? this.catastro;
    this.circuito = circuito ?? this.circuito;
    this.nombre = nombre ?? this.nombre;
    this.latitud = latitud ?? this.latitud;
    this.longitud = longitud ?? this.longitud;
  }
}