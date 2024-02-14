import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class NearhelpScreen extends StatefulWidget {
  const NearhelpScreen({super.key});

  @override
  State<NearhelpScreen> createState() => _NearhelpScreenState();
}

class _NearhelpScreenState extends State<NearhelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenPrimaryColor,
        title: const Text('도움찾기'),
      ),
      body: const DefaultLayout(
        child: Center(
          child: Column(
            children: [Text('도움찾기')],
          ),
        ),
      ),
    );
  }
}
