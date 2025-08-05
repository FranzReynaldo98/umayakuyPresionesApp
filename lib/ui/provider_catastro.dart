import 'package:app/data/catastro_repository_impl.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:flutter/material.dart';

class ProviderCatastro extends ChangeNotifier {
  bool loading = false;
  String mensajeError = '';
  final List<Vivienda> viviendas = [];
  Vivienda viviendaSel = Vivienda.empty();
  CatastroRepositoryImpl catastroRepository = CatastroRepositoryImpl(); 

  void setViviendaSel(Vivienda vivienda) {
    if(viviendaSel.id == vivienda.id) {
      viviendaSel = Vivienda.empty();
    } else {
      viviendaSel = vivienda;
    }
    notifyListeners();
  }

  Future<bool> getViviendasCercanas ({required String circuito, required double longitud, required double latitud}) async {
    bool resultado = true;
    viviendas.clear();
    mensajeError = '';
    loading = true;
    notifyListeners();
    await catastroRepository.getViviendasCercanas(circuito: circuito,longitud: longitud, latitud: latitud)
      .then((result) {
          if(result[error] ?? false) {
            resultado = false;
            mensajeError = result[mensaje];
          } else {
            viviendas.addAll(result['viviendas']);
            for(var v in viviendas) {
              print(v.id);
            }
          }
        });
      loading = false;
      notifyListeners();
      return resultado;
  }
}