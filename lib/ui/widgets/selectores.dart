import 'package:app/ui/widgets/selector_overlay.dart';
import 'package:app/ui/widgets/textos.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class SelectorPrincipal extends StatefulWidget {
  const SelectorPrincipal({Key? key,
    this.textoLabel = "",
    this.errorTexto,
    required this.value,
    required this.onChanged,
    required this.currentItem,
    required this.itemCount,
    this.loading = false,
    this.colorFondo,
    this.colorTexto
  }) : super(key: key);
  final String textoLabel;
  final String? errorTexto;
  final String value;
  final Function onChanged;
  final Function currentItem;
  final int itemCount;
  final bool loading;
  final Color? colorFondo;
  final Color? colorTexto;

  @override
  State<SelectorPrincipal> createState() => _SelectorPrincipalState();
}

class _SelectorPrincipalState extends State<SelectorPrincipal>{
  final LayerLink layerLink = LayerLink();
  DropDownOverlay dropDownOverlay= DropDownOverlay();
  double heightOverlay=45;


  @override
  void initState() {
    super.initState();
  }
  void initSizes(BuildContext context){
    if( !widget.loading ) {
      heightOverlay = widget.itemCount<5?45.ss*widget.itemCount+20 .ss:45*5.ss+20.ss;
    } else {
      heightOverlay = 45 . ss;
    }
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=45.ss;
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(dropDownOverlay.isShow) {
        dropDownOverlay.hideOverlay();
        showOverlay(context);
      }
    });
  }

  void showOverlay(BuildContext context) {
    dropDownOverlay.showOverlay(
      context: context,
      layerLink: layerLink,
      width: MediaQuery.of(context).size.width-70.ss,
      colorFondoM: widget.colorFondo,
      onTapBarrierDismissible: (){
        dropDownOverlay.hideOverlay();
      },
      widgetOverlay: wOverlay(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    initSizes(context);
    bool isError = widget.errorTexto!= null && widget.errorTexto!.isNotEmpty;
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.textoLabel != "")
          TextoLabel(labelTexto: widget.textoLabel, isError: isError,),
          InkWell(
            onTap: (){
              showOverlay(context);
            },
            child: Container(
              width: double.infinity,
              height:60 . ss,
              decoration: BoxDecoration(
                color: widget.colorFondo ?? colorFondo,
                borderRadius: BorderRadius.circular(20.ss),
                border: Border.all(color: isError ? colorError : colorPrincipal, width: 2.ss),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 5.ss, horizontal: 13.ss),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: wDropDownItem(widget.value)
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.ss, horizontal: 13.ss),
                    child: Icon(Icons.arrow_downward, color: widget.colorTexto ?? colorTexto1,),
                  )
                ],
              ),
            ),
          ),
          if( isError )
          Padding(
            padding: EdgeInsets.only(top: 5.ss),
            child: Text(widget.errorTexto!, style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.ss,
              color: colorError
            ),),
          ),
        ],
      ),
    );
  }

  Widget wOverlay(BuildContext context) {
    return widget.loading
    ? Center(child: const CircularProgressIndicator())
    : Scrollbar(
      radius: Radius.circular(10.ss),
      trackVisibility: false,
      interactive: true,
      thickness: 1,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        separatorBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 . ss),
            child: Opacity(
              // ignore: unnecessary_null_comparison
              opacity: colorFondo != null ? 0.5 : 1,
              child: Container(
                width:double.infinity,
                height: 0.5.ss,
                color: widget.colorTexto ?? colorGray1,
              ),
            ),
          );
        },
        itemCount: widget.itemCount,
        itemBuilder: (context,index){
          final e = widget.currentItem(index);
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                widget.onChanged(e,index);
                setState(() {
                  dropDownOverlay.hideOverlay();
                });

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.ss),
                child: wDropDownItem(e)
              )
            ),
          );
        },
      ),
    );
  }

  Widget wDropDownItem(String item) {
    return Container(
      width: double.infinity,
      height:50.ss,
      alignment: Alignment.centerLeft,
      child: item!=""
      ?Text(
        item,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: widget.colorTexto ?? colorTexto1
        ),
      )
      :Text(
        "Seleccione una",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: widget.colorTexto ?? colorTexto1
        ),
      ),
    );
  }
}