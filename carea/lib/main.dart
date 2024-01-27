import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/modules/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const _App(),
  );
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const DefaultLayout(
        child: LoginScreen(),
      ),
    );
  }
}
