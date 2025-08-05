
import 'dart:convert';

import 'package:app/data/configuracion.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/circuito.dart';
import 'package:app/domain/repository/circuitos_repository.dart';
import 'package:http/http.dart' as http;

class CircuitosRepositoryImpl extends CircuitosRepository {
  @override
  Future<Map<String, dynamic>> getCircuitos() async {
    Map<String,dynamic> responseData = {};
    List<Circuito> circuitos = [];
    final url="${api}circuitos";
    final uri=Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if(jsonResponse['data'] != null) {
        for(var e in jsonResponse['data']) {
          circuitos.add(Circuito.fromJSON(e));
        }
      }
      responseData['circuitos'] = circuitos;
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseData[error] = true;
      responseData[mensaje] = jsonResponse[mensaje];
    }
    return responseData;
  }

}