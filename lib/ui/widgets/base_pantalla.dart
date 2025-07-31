import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class BasePantalla extends StatelessWidget {
  const BasePantalla({super.key, required this.title, required this.body, this.padding});
  final String title;
  final Widget body;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: TextStyle(fontSize: 18.ss),)
        )
      ),
      body: Container(
        width: 100.sw,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 30.ss, vertical: 15.ss),
        child: body,
      ),
    );
  }
}