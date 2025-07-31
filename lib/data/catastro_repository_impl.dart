import 'dart:convert';

import 'package:app/data/configuracion.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:app/domain/repository/catastro_repository.dart';
import 'package:http/http.dart' as http;

class CatastroRepositoryImpl extends CatastroRepository{
  @override
  Future<Map<String, dynamic>> getViviendasCercanas({required double longitud, required double latitud}) async {
    Map<String,dynamic> responseData = {};
    List<Vivienda> viviendas = [];
    final url="${api}catastro/viviendas";
    final uri=Uri.parse(url);
    final body = {
      'longitud': longitud.toString(),
      'latitud': latitud.toString()
    };
    print(body);
    final response = await http.post(uri, body: (body));
    if(response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      if(jsonResponse['data'] != null) {
        for(var e in jsonResponse['data']) {
          print(e);
          viviendas.add(Vivienda.fromJSON(e));
        }
      }
      responseData['viviendas'] = viviendas;
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseData[error] = true;
      responseData[mensaje] = jsonResponse[mensaje];
    }
    return responseData;
  }

}