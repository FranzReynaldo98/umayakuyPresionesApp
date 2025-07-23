import 'package:app/ui/registro/pantalla_camara.dart';
import 'package:app/ui/registro/pantalla_registro.dart';
import 'package:app/ui/registro/pantalla_seleccionar_vivienda.dart';

import 'inicio/pantalla_inicio.dart';
import 'crear_sesion/crear_sesion.dart';
import 'package:flutter/material.dart';

class Routes {
  static String get routeInicial => PantallaInicio.route;
  static Map<String,WidgetBuilder> routes(BuildContext context) {
    return {
      PantallaInicio.route: (_) => PantallaInicio(),
      PantallaCrearSesion.route: (_) => PantallaCrearSesion(),
      PantallaRegistro.route: (_) => PantallaRegistro(),
      PantallaCamara.route: (_) => PantallaCamara(),
      PantallaSeleccionarVivienda.route: (_) => PantallaSeleccionarVivienda()
    };
  }
}