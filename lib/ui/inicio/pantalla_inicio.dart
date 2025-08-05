import 'package:app/ui/crear_sesion/crear_sesion.dart';
import 'package:app/ui/provider_sesion.dart';
import 'package:app/ui/registro/pantalla_registro.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/ui/widgets/botones.dart';
import 'package:app/ui/widgets/campos_texto.dart';
import 'package:app/ui/widgets/popup_info.dart';
import 'package:app/utils/path_assets.dart';
import 'package:app/utils/resultado_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizing/sizing_extension.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  static const String route = '/';

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  TextEditingController controllerUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pw = context.watch<ProviderSesion>();
    return BasePantalla(
      title: 'PRESIONES', 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.ss,),
            Image.asset(logoUmayakuy, height: 400.ss),
            CampoTextoPrincipal(
              labelTexto: 'Usuario',
              controller: controllerUsuario,
            ),
            SizedBox(height: 10.ss,),
            BotonPrincipal(
              loading: pw.loading,
              onPressed: () async {
                if(controllerUsuario.text.trim().isNotEmpty) {
                  bool resultado = await context.read<ProviderSesion>().iniciarSesion(controllerUsuario.text);
                  if(mounted && resultado) {
                    final ps = context.read<ProviderSesion>();
                    if(ps.usuario.isNotEmpty) {
                      Navigator.pushNamed(context, PantallaRegistro.route);
                    } else {
                      popupInfo(
                        context, mensaje: 'No hay un usuario activo con ese nombre', 
                        tipoPopup: GetPopupTipo.error.index,
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.pushNamed(context, PantallaCrearSesion.route);
                        }
                      );
                    }
                  }
                } else {
                  print('aqui');
                  Navigator.pushNamed(context, PantallaCrearSesion.route);
                }
                
              }, 
              text: 'INGRESAR'
            )
          ],
        ),
      ),
    );
  }
}