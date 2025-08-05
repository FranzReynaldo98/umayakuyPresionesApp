import 'dart:io';

import 'package:app/domain/model/vivienda.dart';

abstract class PresionesRepository{
  Future<Map<String,dynamic>> registrarPresion({required String sesion, required Vivienda vivienda,required String zona,required double presion,required String urlFoto});
  Future<Map<String,dynamic>> subirFoto({required File foto});
}
