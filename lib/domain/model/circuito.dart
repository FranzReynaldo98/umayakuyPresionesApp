class Circuito {
  int id;
  String geom, nombre;
  Circuito({
    required this.id, required this.geom, required this.nombre
  });

  factory Circuito.fromJSON(Map<String, dynamic> data) => Circuito(
    id: data['id'] ?? 0, geom: data['geom'] ?? '', nombre: data['nombre'] ?? ''
  );
}