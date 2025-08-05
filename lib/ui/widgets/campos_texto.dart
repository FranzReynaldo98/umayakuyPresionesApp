import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class CampoTextoPrincipal extends StatelessWidget {
  const CampoTextoPrincipal({super.key, required this.controller, required this.labelTexto, this.errorTexto, this.onChanged, this.disabled = false, this.textInputType});
  final TextEditingController controller;
  final String labelTexto;
  final String? errorTexto;
  final Function? onChanged;
  final bool disabled;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    bool isError = errorTexto!= null && errorTexto!.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.ss),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelTexto, style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: isError ? colorError : colorPrincipal
          )),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(vertical: 5.ss, horizontal: 13.ss),
            decoration: BoxDecoration(
              border: Border.all(color: isError ? colorError : colorPrincipal, width: 2.ss),
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              keyboardType: textInputType,
              controller: controller,
              enabled: !disabled,
              onChanged: onChanged != null ? (x) => onChanged!(x) : null,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.black
              ),
              decoration: InputDecoration(border: InputBorder.none)
            ),
          ),
          if( isError )
          Padding(
            padding: EdgeInsets.only(top: 5.ss),
            child: Text(errorTexto!, style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.ss,
              color: colorError
            ),),
          ),
        ],
      ),
    );
  }
}

class CampoTextoPassword extends StatefulWidget {
  const CampoTextoPassword({super.key, required this.controller, required this.labelTexto, this.errorTexto, this.onChanged, this.disabled = false, this.textInputType});
  final TextEditingController controller;
  final String labelTexto;
  final String? errorTexto;
  final Function? onChanged;
  final bool disabled;
  final TextInputType? textInputType;

  @override
  State<CampoTextoPassword> createState() => _CampoTextoPasswordState();
}

class _CampoTextoPasswordState extends State<CampoTextoPassword> {
  bool isObscure = true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isError = widget.errorTexto!= null && widget.errorTexto!.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.ss),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelTexto, style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: isError ? colorError : colorPrincipal
          )),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(vertical: 5.ss, horizontal: 13.ss),
            decoration: BoxDecoration(
              border: Border.all(color: isError ? colorError : colorPrincipal, width: 2.ss),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: widget.textInputType,
                    controller: widget.controller,
                    enabled: !widget.disabled,
                    obscureText: isObscure,
                    onChanged: widget.onChanged != null ? (x) => widget.onChanged!(x) : null,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black
                    ),
                    decoration: InputDecoration(border: InputBorder.none)
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  }, 
                  icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, size: 25.ss,)
                )
              ],
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
}