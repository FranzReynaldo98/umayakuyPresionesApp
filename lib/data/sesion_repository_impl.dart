import 'dart:convert';
import 'package:app/data/constantes.dart';
import 'package:app/services/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:app/data/configuracion.dart';
import 'package:app/domain/repository/sesion_repository.dart';

class SesionRepositoryImpl extends SesionRepository{
  @override
  Future<Map<String, dynamic>> crearSesion({required String circuito, required String usuario, required String autorizacion}) async {
    String usuarioFinal = '';
    Map<String,dynamic> responseData = {};

    final url="${api}sesion";
    final uri=Uri.parse(url);
    final body = {
      'password_c': autorizacion,
      'usuario_c': usuario,
      'circuito_c': circuito 
    };
    final response = await http.post(uri, body: body);
    if(response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      usuarioFinal = jsonResponse['data'];
      await LocalStorage.prefs.setString(usuarioLocal, usuarioFinal);
      responseData[usuarioLocal] = usuarioFinal;
      print(usuarioFinal);
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseData[error] = true;
      responseData[mensaje] = jsonResponse[mensaje];
    }
    return responseData;
  }

}