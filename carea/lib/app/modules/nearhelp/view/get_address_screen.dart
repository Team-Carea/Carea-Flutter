import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class AdressSearchScreen extends StatefulWidget {
  const AdressSearchScreen({super.key});

  @override
  State<AdressSearchScreen> createState() => _AdressSearchScreenState();
}

class _AdressSearchScreenState extends State<AdressSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultLayout(
        child: Center(
          child: Column(),
        ),
      ),
    );
  }
}
