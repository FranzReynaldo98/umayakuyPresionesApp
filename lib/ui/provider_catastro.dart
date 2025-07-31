import 'package:app/data/catastro_repository_impl.dart';
import 'package:app/data/constantes.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:flutter/material.dart';

class ProviderCatastro extends ChangeNotifier {
  bool loading = false;
  String mensajeError = '';
  int idSeleccionado = -1;
  final List<Vivienda> viviendas = [];
  CatastroRepositoryImpl catastroRepository = CatastroRepositoryImpl(); 
  void setIdSeleccionado(Vivienda v) {
    if(idSeleccionado == v.id) {
      idSeleccionado = -1;
    } else {
      idSeleccionado = v.id;
    }
    notifyListeners();
  }

  Future<bool> getViviendasCercanas ({required double longitud, required double latitud}) async {
    bool resultado = true;
    viviendas.clear();
    mensajeError = '';
    loading = true;
    notifyListeners();
    await catastroRepository.getViviendasCercanas(longitud: longitud, latitud: latitud)
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