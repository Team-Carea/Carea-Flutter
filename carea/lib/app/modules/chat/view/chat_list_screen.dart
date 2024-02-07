import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class ChatlistScreen extends StatefulWidget {
  const ChatlistScreen({super.key});

  @override
  State<ChatlistScreen> createState() => _ChatlistScreenState();
}

class _ChatlistScreenState extends State<ChatlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenPrimaryColor,
        title: const Text('대화 목록'),
      ),
      body: const DefaultLayout(
        child: Center(
          child: Column(
            children: [Text('대화 목록')],
          ),
        ),
      ),
    );
  }
}
