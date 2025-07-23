import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class CampoTextoPrincipal extends StatelessWidget {
  const CampoTextoPrincipal({super.key, required this.controller, required this.labelTexto, this.errorTexto, this.onChanged});
  final TextEditingController controller;
  final String labelTexto;
  final String? errorTexto;
  final Function? onChanged;

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
              controller: controller,
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