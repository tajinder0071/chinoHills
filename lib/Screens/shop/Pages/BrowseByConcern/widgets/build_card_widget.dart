import 'package:flutter/material.dart';

class BuildCardWidget extends StatelessWidget {
  final Color? color;
  final Widget child;
  double padding;

  BuildCardWidget(
      {super.key, this.color, required this.child, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
