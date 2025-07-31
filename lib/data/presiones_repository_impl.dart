import 'dart:convert';

import 'package:app/data/configuracion.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:app/domain/repository/presiones_repository.dart';
import 'package:http/http.dart' as http;

class PresionesRepositoryImpl extends PresionesRepository{
  @override
  Future<Map<String, dynamic>> registrarPresiones({required Vivienda vivienda,required String zona,required double presion,required String urlFoto}) async {
    Map<String,dynamic> responseData = {};

    final url="${api}sesion";
    final uri=Uri.parse(url);
    final body = {
      'geom': vivienda.geom,
      'catastro': vivienda.catastro,
      'circuito': vivienda.circuito,
      'nombre': vivienda.nombre,
      'zona': zona,
      'foto': urlFoto
    };
    final response = await http.post(uri, body: body);
    if(response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseData[error] = true;
      responseData[mensaje] = jsonResponse[mensaje];
    }
    return responseData;
  }
  

}