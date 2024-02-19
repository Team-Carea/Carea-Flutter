import 'package:carea/app/common/component/progress_bar.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:flutter/material.dart';

void showSuccessConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(20),
          height: getScreenHeight(context) * 0.28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              const Text('✅ 인증되었습니다!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              const Text('도움 인증 경험치',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const Text('+10xp ✨',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              const SizedBox(height: 18),
              const ExpBar(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('확인'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
