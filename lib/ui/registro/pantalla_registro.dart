import 'dart:io';

import 'package:app/ui/provider_registro.dart';
import 'package:app/ui/provider_sesion.dart';
import 'package:app/ui/registro/pantalla_camara.dart';
import 'package:app/ui/registro/pantalla_seleccionar_vivienda.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/ui/widgets/botones.dart';
import 'package:app/ui/widgets/campos_texto.dart';
import 'package:app/ui/widgets/popup_info.dart';
import 'package:app/ui/widgets/selectores.dart';
import 'package:app/ui/widgets/textos.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/resultado_enum.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizing/sizing.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  static const String route = '/registro';

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final TextEditingController _controllerPresion = TextEditingController();
  final TextEditingController _controllerCatastro = TextEditingController();
  final TextEditingController _controllerCircuito = TextEditingController();
  final TextEditingController _controllerNombre = TextEditingController();
  //File? imageFile;
  List<String> zonas = ['Alta', 'Medio', 'Baja'];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controllerCircuito.text = context.read<ProviderSesion>().circuito;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final pRegistroW = context.watch<ProviderRegistro>();
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
                    context.read<ProviderRegistro>().setFoto(result as File);
                    
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
                width: 200.ss,
                height: 300.ss,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400
                ),
                child: pRegistroW.foto == null ? Icon(
                  Icons.camera_enhance,
                  size: 50.ss,
                  color: colorPrincipal,
                ) : Stack(
                  children: [
                    SizedBox(),
                    Center(child: Image.file(pRegistroW.foto!, fit: BoxFit.fill)),
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
            SizedBox(height: 20.ss,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () async {
                  await Navigator.pushNamed(context, PantallaSeleccionarVivienda.route);
                  final v = context.read<ProviderRegistro>().vivienda;
                  _controllerCatastro.text = v.catastro;
                  _controllerNombre.text = v.nombre;

                }, 
                iconAlignment: IconAlignment.start,
                icon: Icon(Icons.search, color: colorPrincipal, size: 25.ss,),
                label: Text(
                  'Buscar vivienda',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: colorPrincipal
                  ),
                ),
              ),
            ),
            CampoTextoPrincipal(
              labelTexto: 'Catastro',
              controller: _controllerCatastro,
              disabled: true,
              //onChanged: pSesionR.setUsuario
            ),
            CampoTextoPrincipal(
              labelTexto: 'Circuito',
              controller: _controllerCircuito,
              disabled: true,
              //onChanged: pSesionR.setUsuario
            ),
            CampoTextoPrincipal(
              labelTexto: 'Nombre',
              controller: _controllerNombre,
              disabled: true,
              //onChanged: pSesionR.setUsuario
            ),
            SelectorPrincipal(
              textoLabel: 'Zona',
              value: pRegistroW.zona, 
              onChanged: (x,i) {
                pRegistroW.setZona(zonas[i]);
              }, 
              currentItem: (x) => zonas[x], 
              itemCount: zonas.length
            ),
            CampoTextoPrincipal(
              labelTexto: 'Presión',
              controller: _controllerPresion,
              textInputType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (String x) => pRegistroW.setPresion(x.isNotEmpty ? double.parse(x) : 0.0)
            ),
            TextoError(texto: pRegistroW.mensajeError),
            SizedBox(height: 10.ss),
            BotonPrincipal(
              loading: pRegistroW.loading,
              onPressed: () async {
                final result = await context.read<ProviderRegistro>().registrar(context.read<ProviderSesion>().usuario);
                if(result && mounted) {
                  limpiarCampos();
                  popupInfo(context, mensaje: 'Registrado con éxito', tipoPopup: GetPopupTipo.exito.index);
                } else {
                  popupInfo(context, mensaje: pRegistroW.mensajeError, tipoPopup: GetPopupTipo.error.index);
                }
              }, 
              text: 'REGISTRAR'
            )
          ],
        ),
      )
    );
  }

  void limpiarCampos() {
    _controllerCatastro.text = '';
    _controllerNombre.text = '';
    _controllerPresion.text = '';
    final rp = context.read<ProviderRegistro>();
    rp.iniciar();
  }
}