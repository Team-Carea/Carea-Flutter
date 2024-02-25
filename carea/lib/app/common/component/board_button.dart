import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class BoardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String subtitle;

  const BoardButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.black,
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.faintGray),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
