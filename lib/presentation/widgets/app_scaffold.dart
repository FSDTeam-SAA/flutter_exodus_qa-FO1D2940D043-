import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool removePadding;

  const AppScaffold({
    super.key,
    required this.child,
    this.removePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 16),
        child: child,
      ),
    );
  }
}
