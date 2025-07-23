
abstract class SesionRepository{
  Future<Map<String,dynamic>> crearSesion({required String circuito, required String usuario, required String autorizacion});
}
