import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class VoiceRecordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const VoiceRecordButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.redAccentColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.mic_none, color: Colors.white),
        iconSize: 50,
        onPressed: onPressed,
      ),
    );
  }
}
