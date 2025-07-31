
abstract class CatastroRepository{
  Future<Map<String,dynamic>> getViviendasCercanas({required double longitud, required double latitud});
}
