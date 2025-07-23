import 'package:app/ui/provider_sesion.dart';
import 'package:app/ui/registro/pantalla_registro.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/ui/widgets/botones.dart';
import 'package:app/ui/widgets/campos_texto.dart';
import 'package:app/ui/widgets/textos.dart';
import 'package:app/utils/path_assets.dart';
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
    Navigator.pushNamed(context, PantallaRegistro.route);
    /*print('object');
    final res = await context.read<ProviderSesion>().crearSesion();
    
    if (res && mounted) {
      Navigator.pushNamed(context, PantallaRegistro.route);
    }*/
  }
}

//await LocalStorage.prefs.setString("${loginData.dni}seed", jsonResponse["data"]["sessionItem"]["requester"]["seed"]);