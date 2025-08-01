import 'package:app/ui/provider_sesion.dart';
import 'package:app/ui/registro/pantalla_registro.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/ui/widgets/botones.dart';
import 'package:app/ui/widgets/campos_texto.dart';
import 'package:app/ui/widgets/textos.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/path_assets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizing/sizing.dart';

class PantallaCrearSesion extends StatefulWidget {
  const PantallaCrearSesion({super.key});

  static const String route = '/crear_sesion';

  @override
  State<PantallaCrearSesion> createState() => _PantallaCrearSesionState();
}

class _PantallaCrearSesionState extends State<PantallaCrearSesion> {
  final TextEditingController _controllerCircuito = TextEditingController(); 
  final TextEditingController _controllerUsuario = TextEditingController(); 
  final TextEditingController _controllerAutorizacion = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    final pSesionR = context.read<ProviderSesion>();
    final pSesionW = context.watch<ProviderSesion>();
    return BasePantalla(
      title: 'PRESIONES',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(logoUmayakuy, height: 200.ss),
            CampoTextoPrincipal(
              labelTexto: 'Circuito',
              controller: _controllerCircuito,
              onChanged: pSesionR.setCircuito
            ),
            CampoTextoPrincipal(
              labelTexto: 'Usuario',
              controller: _controllerUsuario,
              onChanged: pSesionR.setUsuario
            ),
            CampoTextoPrincipal(
              labelTexto: 'Autorización',
              controller: _controllerAutorizacion,
              onChanged: pSesionR.setAutorizacion
            ),
            SizedBox(height: 15.ss,),
            TextoError(texto: pSesionW.mensajeError),
            BotonPrincipal(
              loading: pSesionW.loading,
              onPressed: () { 
                iniciarSesion();
              }, 
              text: 'CREAR SESIÓN'
            )
          ],
        ),
      ),
    );
  }
  void iniciarSesion() async {
    if(await tieneInternet()) {
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: colorError,content: Text('No tienes conexión a internet')));
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tienes conexión a internet')));
      //Navigator.pushNamed(context, PantallaRegistro.route);
      print('object');
      final res = await context.read<ProviderSesion>().crearSesion();
      
      if (res && mounted) {
        Navigator.pushNamed(context, PantallaRegistro.route);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: colorError,content: Text('No tienes conexión a internet')));
    }
    
    
  }
}

Future<bool> tieneInternet() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

  // This condition is for demo purposes only to explain every connection type.
  // Use conditions which work for your requirements.
  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
    // Mobile network available.
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
    // Wi-fi is available.
    // Note for Android:
    // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
  }
  return false;
}