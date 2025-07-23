
import 'package:app/data/constantes.dart';
import 'package:app/data/sesion_repository_impl.dart';
import 'package:app/services/local_storage.dart';
import 'package:flutter/material.dart';

const camposObligatorios = 'Complete todos los campos';

class ProviderSesion extends ChangeNotifier {

  bool loading = false;
  String usuario = '';
  String circuito = '';
  String autorizacion = '';
  String mensajeError = '';
  SesionRepositoryImpl sesionRepository = SesionRepositoryImpl(); 

  void setUsuario(String usuario) {
    this.usuario = usuario;
    print(this.usuario);
    isValid();
    notifyListeners();
  }

  void setCircuito(String circuito) {
    this.circuito = circuito;
    isValid();
    notifyListeners();
  }

  void setAutorizacion(String autorizacion) {
    this.autorizacion = autorizacion;
    isValid();
    notifyListeners();
  }

  void iniciar() {
    loading = false;
    usuario = '';
    circuito = '';
    autorizacion = '';
    mensajeError = '';
  }

  bool buscarLocalUsuario(String nombreUsuario) {
    usuario = LocalStorage.prefs.getString(usuarioLocal) ?? '';
    return nombreUsuario == usuario;
  }

  bool isValid() {
    bool resultado = circuito.isNotEmpty && usuario.isNotEmpty && autorizacion.isNotEmpty;
    print(resultado);
    if(!resultado) {
      mensajeError = camposObligatorios;
    } else {
      mensajeError = '';
    }
    notifyListeners();
    return resultado;
  }

  Future<bool> crearSesion() async {
    bool resultado = true;
    if(isValid()) {
      loading = true;
      notifyListeners();
      await sesionRepository.crearSesion(circuito: circuito, usuario: usuario, autorizacion: autorizacion)
        .then((result) {
          if(result[error] ?? false) {
            resultado = false;
            mensajeError = result[mensaje];
          } else {
            usuario = result[usuarioLocal];
          }
        });
      loading = false;
      notifyListeners();
    }
    return resultado;
  }

}
