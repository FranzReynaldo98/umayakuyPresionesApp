import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class TextoError extends StatelessWidget {
  const TextoError({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
        fontSize: 14.ss,
        color: colorError
      ),
    );
  }
}

class TextoLabel extends StatelessWidget {
  const TextoLabel({super.key, required this.labelTexto, this.isError = false});
  final String labelTexto;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Text(labelTexto, style: Theme.of(context).textTheme.labelMedium!.copyWith(
      color: isError ? colorError : colorPrincipal
    ));
  }
}