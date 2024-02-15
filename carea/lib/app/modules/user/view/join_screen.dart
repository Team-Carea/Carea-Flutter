import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/custom_text_form_field.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/auth_storage.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Title(),
                SizedBox(height: getScreenWidth(context) * 0.2),
                const Text(
                  '닉네임',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  hintText: '닉네임을 입력해주세요',
                  onChanged: (String value) {},
                ),
                SizedBox(height: getScreenWidth(context) * 0.04),
                const Text(
                  '자기소개',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  hintText: '자기소개를 입력해주세요',
                  onChanged: (String value) {},
                ),
                SizedBox(height: getScreenWidth(context) * 0.04),
                const Text(
                  '이메일',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {},
                ),
                SizedBox(height: getScreenWidth(context) * 0.04),
                const Text(
                  '비밀번호',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (String value) {},
                  obscureText: true,
                ),
                SizedBox(height: getScreenWidth(context) * 0.08),
                CustomElevatedButton(
                  text: '회원 가입하기',
                  screenRoute: () async {},
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: getScreenWidth(context) * 0.04),
        const Text(
          "회원 가입",
          style: joinTitleTextStyle,
        ),
        const Divider(
          color: AppColors.greenPrimaryColor,
          thickness: 8,
        ),
        const Text(
          '당신을 소개할 수 있는 프로필을 만들어주세요',
          style: descriptionTextStyle,
        )
      ],
    );
  }
}
