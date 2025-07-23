import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing_extension.dart';

class BotonPrincipal extends StatelessWidget {
  const BotonPrincipal({super.key, required this.onPressed, required this.text, this.loading = false});
  final VoidCallback onPressed;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(loading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.ss),
            child: CircularProgressIndicator(
              color: colorFondo,
            ),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18.ss),
          ),
        ],
      )
    );
  }
}