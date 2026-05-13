import 'package:flutter/material.dart';

class BilanzaCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const BilanzaCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}