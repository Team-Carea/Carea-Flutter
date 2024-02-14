import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExpBar extends StatefulWidget {
  const ExpBar({Key? key}) : super(key: key);

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  double exp = 0.5;
  String userID = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: 350,
            animation: true,
            lineHeight: 20,
            animationDuration: 1000,
            percent: exp,
            center: const Text("50.0%"),
            linearGradient: const LinearGradient(
              colors: <Color>[
                AppColors.extraLightGray,
                AppColors.bluePrimaryColor
              ],
            ),
            linearGradientBackgroundColor: const LinearGradient(
              colors: <Color>[
                AppColors.extraLightGray,
                AppColors.bluePrimaryColor
              ],
            ),
          ),
        ],
      ),
    );
  }
}
