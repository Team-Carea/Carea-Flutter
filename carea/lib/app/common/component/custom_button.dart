import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final dynamic screenRoute;

  const CustomElevatedButton(
      {super.key, required this.text, required this.screenRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.greenPrimaryColor,
        foregroundColor: AppColors.darkGreenPrimaryColor,
      ),
      onPressed: screenRoute,
      child: Text(
        text,
        style: elevatedBtnTextStyle,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final dynamic screenRoute;

  const CustomTextButton(
      {super.key, required this.text, required this.screenRoute});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        foregroundColor: AppColors.darkGray,
      ),
      onPressed: screenRoute,
      child: Text(
        text,
        style: textBtnTextStyle,
      ),
    );
  }
}
