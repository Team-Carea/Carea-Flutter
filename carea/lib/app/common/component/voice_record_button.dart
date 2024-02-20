import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class VoiceRecordButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Function(bool) onRecordingStateChanged; // 녹음 상태 변경 콜백 추가

  const VoiceRecordButton({
    super.key,
    required this.onPressed,
    required this.onRecordingStateChanged,
  });

  @override
  State<VoiceRecordButton> createState() => _VoiceRecordButtonState();
}

class _VoiceRecordButtonState extends State<VoiceRecordButton> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.redAccentColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon:
            Icon(isRecording ? Icons.mic : Icons.mic_none, color: Colors.white),
        iconSize: 50,
        onPressed: () {
          setState(() {
            isRecording = !isRecording;
            widget.onRecordingStateChanged(isRecording); // 상태 변경을 부모 위젯에 알림
          });
          widget.onPressed(); // 부모 위젯에서 전달받은 onPressed 콜백 실행
        },
      ),
    );
  }
}
