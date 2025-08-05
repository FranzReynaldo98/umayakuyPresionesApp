import 'dart:io';

import 'package:app/data/constantes.dart';
import 'package:app/data/presiones_repository_impl.dart';
import 'package:app/domain/model/vivienda.dart';
import 'package:flutter/material.dart';

class ProviderRegistro extends ChangeNotifier {
  PresionesRepositoryImpl presionesRepositoryImpl = PresionesRepositoryImpl();
  Vivienda vivienda = Vivienda.empty();
  double presion = 0.0;
  String zona = '';
  File? foto;
  String urlFoto = '';
  String mensajeError = '';
  bool loading = false;
  void iniciar () {
    vivienda = Vivienda.empty();
    presion = 0.0;
    zona = '';
    foto = null;
    mensajeError = '';
    urlFoto = '';
    loading = false;
    notifyListeners();
  }

  void setPresion(double p) {
    presion = p;
  }

  void setZona(String z) {
    zona = z;
    notifyListeners();
  }

  void setVivienda(Vivienda v) {
    vivienda = v;
    notifyListeners();
  }

  void setFoto(File f) {
    foto = f;
    notifyListeners();
  }

  Future<bool> subirFoto() async {
    bool resultado = false;
    await presionesRepositoryImpl.subirFoto(foto: foto!)
      .then((result) {
          if(result[error] ?? false) {
            resultado = false;
            mensajeError = result[mensaje];
          } else {
            urlFoto = result['url'];
            resultado = true;
          }
        });
    return resultado;
  }

  bool isValid() {
    bool resultado = true;
    mensajeError = '';
    if(foto == null || presion <= 0 || zona.isEmpty || vivienda.id == 0) {
      resultado = false;
      mensajeError = 'Revise los datos';
    }
    notifyListeners();
    return resultado;
  }

  Future<bool> registrar(String sesion) async {
    bool resultado = false;
    if(isValid()) {
      loading = true;
      notifyListeners();
      bool res = await subirFoto();
      if(res) {
        await presionesRepositoryImpl.registrarPresion(
          sesion: sesion, vivienda: vivienda, zona: zona, presion: presion, urlFoto: urlFoto)
          .then((result) {
              if(result[error] ?? false) {
                mensajeError = result[mensaje];
              } else {
                resultado = true;
              }
            });
      }
      loading = false;
      notifyListeners();
    }
    return resultado;
  }
}