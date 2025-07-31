import 'package:app/domain/model/vivienda.dart';

abstract class PresionesRepository{
  Future<Map<String,dynamic>> registrarPresiones({required Vivienda vivienda,required String zona,required double presion,required String urlFoto});
}
