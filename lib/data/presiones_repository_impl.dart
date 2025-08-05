import 'dart:convert';
import 'dart:io';

import 'package:app/data/configuracion.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:app/domain/repository/presiones_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class PresionesRepositoryImpl extends PresionesRepository{
  @override
  Future<Map<String, dynamic>> registrarPresion({required String sesion, required Vivienda vivienda,required String zona,required double presion,required String urlFoto}) async {
    Map<String,dynamic> responseData = {};

    final url="${api}presion";
    final uri=Uri.parse(url);
    final body = {
      'geom_c': vivienda.geom,
      'catastro_c': vivienda.catastro,
      'circuito_c': vivienda.circuito,
      'nombre_c': vivienda.nombre,
      'zona_c': zona,
      'foto_c': urlFoto,
      'sesion_c': sesion,
      'presion_c': presion.toString()
    };
    print(body);
    final response = await http.post(uri, body: body);
    if(response.statusCode == 201) {
      print('okey');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseData[error] = true;
      responseData[mensaje] = jsonResponse[mensaje];
    }
    return responseData;
  }

  @override
  Future<Map<String, dynamic>> subirFoto({required File foto}) async {
    Map<String,dynamic> responseData = {};
    final url="${api}upload";
    final uri = Uri.parse(url);

    // Crear request tipo multipart
    final request = http.MultipartRequest("POST", uri);

    // Añadir archivo
    request.files.add(
      await http.MultipartFile.fromPath(
        'foto', // nombre esperado por el backend
        foto.path,
        filename: basename(foto.path),
      ),
    );

    // Enviar la solicitud
    final response = await request.send();

    // Leer la respuesta
    final respuestaFinal = await http.Response.fromStream(response);

    // Ver resultado
    if (response.statusCode == 200) {
      print('Archivo subido correctamente');
      var jsonResponse = jsonDecode(respuestaFinal.body) as Map<String, dynamic>;
      final data = jsonResponse['data'];
      responseData['url'] = '${apiSinPort}presiones/${data['archivo']}';
    } else {
      print('Error al subir: ${response.statusCode}');
      print(respuestaFinal.body);
      responseData[error] = true;
      responseData[mensaje] = respuestaFinal.body;
    }
    return responseData;
  }


}