
abstract class CatastroRepository{
  Future<Map<String,dynamic>> getViviendasCercanas({required String circuito, required double longitud, required double latitud});
}
