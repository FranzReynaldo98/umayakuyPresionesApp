import 'package:app/ui/widgets/botones.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/resultado_enum.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing_extension.dart';

Future<void> popupInfo(BuildContext context, {required String mensaje,int? tipoPopup, VoidCallback? onPressed}) async => await showDialog(
  barrierLabel: "", barrierDismissible: true, context: context,
  builder: (BuildContext ctx){
    return StatefulBuilder(
      builder: (BuildContext ctx,StateSetter setState){
        return SimpleDialog(
          alignment: Alignment.center, insetPadding: EdgeInsets.symmetric(horizontal: 53.ss), contentPadding: EdgeInsets.zero, titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.ss)
          ),
          children: [
            SizedBox(),
            _WView(mensaje: mensaje, tipoPopup: tipoPopup, onPressed: onPressed,),
          ],
        );
      }
    );
  }
); 

class _WView extends StatelessWidget {
  const _WView({Key? key, required this.mensaje, this.tipoPopup, this.onPressed}) : super(key: key);
  final String mensaje;
  final int? tipoPopup;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final tpopup = tipoPopup ?? GetPopupTipo.info.index;
    return Container(
      padding: EdgeInsets.all(10),
      width: 500 . ss,
      child: Column(
        children: [
          GetPopupTipo.exito.index == tpopup ?
          Icon(Icons.check, size: 70.ss, color: colorExito,) : 
          GetPopupTipo.error.index == tpopup ?
          Icon(Icons.error, size: 70.ss, color: colorError) :
          GetPopupTipo.advertencia.index == tpopup ?
          Icon(Icons.warning, size: 70.ss, color: colorAdvertencia,) :
          Icon(Icons.info, size: 70.ss, color: colorInfo,),
          SizedBox(height: 10 .ss,),
          Text(mensaje),
          SizedBox(height: 10 .ss,),
          BotonPrincipal(
            onPressed: onPressed != null ? () {
              Navigator.pop(context);
              onPressed!();
            } : () {
              Navigator.pop(context);
            }, 
            text: "Entendido"
          )
        ],
      ),
    );
  }
}
