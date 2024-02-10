import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appbar;
  final Widget child;

  const DefaultLayout({
    this.appbar,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: child,
    );
  }
}
