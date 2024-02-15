// nearhelp_screen -> 도움 올리기
// check_near_screen -> 올려진 도움 상세 정보

import 'package:carea/app/common/component/progress_bar.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NearHelpCheck extends StatefulWidget {
  const NearHelpCheck({super.key});

  @override
  State<NearHelpCheck> createState() => _NearHelpCheckState();
}

class _NearHelpCheckState extends State<NearHelpCheck> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.darkGray,
            radius: 50.0,
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "캐리아유저 1",
                  style: TextStyle(fontSize: 20, color: AppColors.black),
                ),
              ),
              // ExpBar 추가
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 350,
                      height: 30,
                      child: Text(
                        '청파동 도움 구합니다~',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    height: 370,
                    child: Text(
                      "오늘 학교 앞에서 저 좀 도아주실분 구합니다 ~오늘 학교 앞에서 저 좀 도아주실분 구합니다 ~오늘 학교 앞에서 저 좀 도아주실분 구합니다 ~오늘 학교 앞에서 저 좀 도아주실분 구합니다 ~ ",
                      style: TextStyle(fontSize: 16, color: AppColors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  '채팅하기',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
