import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
class DropDownOverlay{
  OverlayEntry? entry;
  double heightOverlay=0.0;
  double heightDropDownItem=70;
  bool isShow = false;

  set sHeightOverlay(double heightOverlay) => this.heightOverlay=heightOverlay;
  set sHeightDropDownItem(double heightDropDownItem) => this.heightDropDownItem=heightDropDownItem;

  void showOverlay({
    required BuildContext context,required LayerLink layerLink,
    required VoidCallback onTapBarrierDismissible,
    required Widget widgetOverlay, double? width,
    Color? colorFondoM
  }){
    
    isShow = true;
    final overlay=Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size=renderBox.size;
    entry=OverlayEntry(
      
      maintainState: true,
      //opaque: true,
      builder: (context) => Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: onTapBarrierDismissible,
              onVerticalDragDown: (DragDownDetails d) => onTapBarrierDismissible,
              onVerticalDragStart: (d) {
                onTapBarrierDismissible();
              },
            ),
          ),
          Positioned(
            width: width ?? size.width,
            height: heightOverlay,
            top: 0,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: true,
              //offset: Offset(0,size.height / 2),
              offset: Offset(0,size.height+5.ss),
              //offset: Offset(0,0),

              /*Offset(0,
              (offset1.dy+size.height+heightOverlay+WidgetDefaults.heightSeparatedDropDown)>WidgetDefaults.sheight
              ?-heightOverlay-WidgetDefaults.heightSeparatedDropDown
              :size.height+WidgetDefaults.heightSeparatedDropDown),*/
              child: buildOverlay(widgetOverlay, colorFondoM: colorFondoM),
            )
          ),
        ],
      ),
    );
    overlay.insert(entry!);
  }

  void hideOverlay(){
    isShow = false;
    entry?.remove();
    entry=null;
  }

  Widget buildOverlay(Widget widgetOverlay, {Color? colorFondoM} ) => Material(
    color: Colors.transparent,
    clipBehavior: Clip.none,
    /*borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15 * Responsive.scaleWidth),
      bottomRight: Radius.circular(15 * Responsive.scaleWidth),
    ),*/
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10 . ss),
      clipBehavior: Clip.none,
      decoration: _boxDecoration(colorFondoM),
      //padding: EdgeInsets.symmetric(vertical:10*Responsive.scaleHeight),
      child: widgetOverlay
    ),
  );

  void showOverlayButton({required BuildContext context,required LayerLink layerLink,required VoidCallback onTapBarrierDismissible,required Widget widgetOverlay, required Widget widget}){
    isShow = true;
    final overlay=Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size=renderBox.size;
    entry=OverlayEntry(
      maintainState: true,
      builder: (context) => Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: onTapBarrierDismissible,
              onVerticalDragDown: (DragDownDetails d) => onTapBarrierDismissible,
              onVerticalDragStart: (d) {
                onTapBarrierDismissible();
              },
            ),
          ),
          Positioned(
            width: size.width,
            height: heightOverlay + size.height,
            top: 0,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: true,
              offset: Offset(0,0),
              child: buildOverlayButton(widgetOverlay,widget: widget,size: size),
            )
          ),
        ],
      ),
    );
    overlay.insert(entry!);
  }

  Widget buildOverlayButton(Widget widgetOverlay, {required Widget widget,required Size size, Color? colorFondoM} ) => Material(
    color: Colors.transparent,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15 * Responsive.scaleWidth),
          bottomRight: Radius.circular(15 * Responsive.scaleWidth),
        ),
      ),*/
      //padding: EdgeInsets.symmetric(vertical:10*Responsive.scaleHeight),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(),
          Positioned(
            top: size.height / 2,
            //height: 40,
            width: size.width,
            child: Container(
              padding: EdgeInsets.only(top: size.height / 2,bottom: 20 . ss),
              decoration: _boxDecoration(colorFondoM),
              child: widgetOverlay
            ),
          ),
          Positioned(
            top: 0,
            width: size.width,
            child: widget,
          ),
          
        ],
      )
    ),
  );

  BoxDecoration _boxDecoration(Color? colorFondoM) => BoxDecoration(
    color: colorFondoM ?? colorFondo,
    border: Border.all(
      width: 0.5 . ss,
      color: colorPrincipal
    ),
    borderRadius: BorderRadius.circular(10 . ss),
    boxShadow: [
      BoxShadow(
        offset: Offset(4 . ss, 4 . ss),
        blurRadius: 20
      )
    ]
  );
}

