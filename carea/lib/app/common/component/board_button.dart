import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class BoardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const BoardButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          height: 80,
          width: 350,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.yellowPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
