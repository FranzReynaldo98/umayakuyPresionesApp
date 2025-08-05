
import 'package:app/data/circuitos_repository_impl.dart';
import 'package:app/data/constantes.dart';
import 'package:app/data/sesion_repository_impl.dart';
import 'package:app/domain/model/circuito.dart';
import 'package:app/services/local_storage.dart';
import 'package:flutter/material.dart';

const camposObligatorios = 'Complete todos los campos';

class ProviderSesion extends ChangeNotifier {

  bool loading = false;
  bool loadingCircuitos = false;
  String usuario = '';
  String circuito = '';
  String autorizacion = '';
  String mensajeError = '';
  List<Circuito> circuitos = [];
  SesionRepositoryImpl sesionRepository = SesionRepositoryImpl(); 
  CircuitosRepositoryImpl circuitosRepository = CircuitosRepositoryImpl();

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
    getCircuitos();
  }

  /*bool buscarLocalUsuario(String nombreUsuario) {
    usuario = LocalStorage.prefs.getString(usuarioLocal) ?? '';
    print(usuario);
    return nombreUsuario == usuario;
  }*/

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
    } else {
      resultado = false;
    }
    return resultado;
  }

  Future<bool> iniciarSesion(String usuarioC) async {
    bool resultado = true;
      loading = true;
      notifyListeners();
      await sesionRepository.iniciarSesion(usuario: usuarioC)
        .then((result) {
          if(result[error] ?? false) {
            resultado = false;
            mensajeError = result[mensaje];
          } else {
            usuario = result['usuario'];
            circuito = result['circuito'];
          }
        });
      loading = false;
      notifyListeners();
    return resultado;
  }

  Future<bool> getCircuitos() async {
    bool resultado = true;
    loadingCircuitos = true;
    notifyListeners();
    await circuitosRepository.getCircuitos()
      .then((result) {
        if(result[error] ?? false) {
          resultado = false;
          mensajeError = result[mensaje];
        } else {
          circuitos = result['circuitos'];
        }
      });
    loadingCircuitos = false;
    notifyListeners();
    return resultado;
  }

}
