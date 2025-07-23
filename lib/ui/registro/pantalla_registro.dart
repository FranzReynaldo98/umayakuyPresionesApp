import 'dart:io';

import 'package:app/ui/registro/pantalla_camara.dart';
import 'package:app/ui/registro/pantalla_seleccionar_vivienda.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/ui/widgets/botones.dart';
import 'package:app/ui/widgets/campos_texto.dart';
import 'package:app/ui/widgets/textos.dart';
import 'package:app/utils/app_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizing/sizing.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  static const String route = '/registro';

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final TextEditingController _controllerPresion = TextEditingController();
  File? imageFile;
  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      title: 'PRESIONES', 
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                TextoLabel(labelTexto: 'Fotografía'),
              ],
            ),
            SizedBox(height: 5.ss),
            InkWell(
              onTap: () async {
                final status = await Permission.camera.request();
                if(status.isGranted){
                  final cameras = await availableCameras();

                    //context.read<PortalProvider>().setDeviceCameras(cameras);
                  
                  try{
                    final result = await Navigator.pushNamed(context, PantallaCamara.route);
                    print(result);
                    imageFile = result as File;
                    setState(() {});
                  }catch (e) {
                    print(e);
                  }
                }
                else{
                  //instancePopupSecondphase.popupDeniedPermission();
                }
                print('tapp');
              },
              child: Container(
                width: 300.ss,
                height: 400.ss,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400
                ),
                child: imageFile == null ? Icon(
                  Icons.camera_enhance,
                  size: 70.ss,
                  color: colorPrincipal,
                ) : Stack(
                  children: [
                    SizedBox(),
                    Center(child: Image.file(imageFile!, fit: BoxFit.fill)),
                    Container(
                      width: double.infinity,
                      height: 15.ss,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(100, 100, 100, 0.3)
                      ),
                      child: Text('Para capturar otra foto haga tap en la imagen', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.ss),
            CampoTextoPrincipal(
              labelTexto: 'Presión',
              controller: _controllerPresion,
              //onChanged: pSesionR.setUsuario
            ),
            SizedBox(height: 10.ss),
            BotonPrincipal(
              onPressed: () {
                Navigator.pushNamed(context, PantallaSeleccionarVivienda.route);
              }, 
              text: 'REGISTRAR'
            )
          ],
        ),
      )
    );
  }
}