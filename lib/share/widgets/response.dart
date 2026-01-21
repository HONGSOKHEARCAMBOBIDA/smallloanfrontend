import 'package:flutter/material.dart';
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget web;

  const Responsive({required this.mobile, required this.web});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 700 ? mobile : web;
      },
    );
  }
}
