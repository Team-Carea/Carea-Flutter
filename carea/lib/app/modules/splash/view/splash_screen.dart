import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: SvgPicture.asset('asset/svg/carea_logo.svg'),
      ),
    );
  }
}
