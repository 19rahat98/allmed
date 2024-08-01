import 'package:flutter/material.dart';

class HBox extends StatelessWidget {
  const HBox(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
