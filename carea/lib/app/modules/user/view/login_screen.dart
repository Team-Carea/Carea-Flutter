import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/custom_text_form_field.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                _Title(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                const Text(
                  '이메일',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  onChanged: (String value) {},
                  hintText: '이메일을 입력해주세요',
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                const Text(
                  '비밀번호',
                  style: inputTitleTextStyle,
                ),
                CustomTextFormField(
                  onChanged: (String value) {},
                  hintText: '비밀번호를 입력해주세요',
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                CustomElevatedButton(
                  text: '로그인',
                  screenRoute: () {},
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                CustomTextButton(
                  text: '아직 회원이 아니신가요? 회원가입',
                  screenRoute: () {},
                ),
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
        SvgPicture.asset(
          'asset/svg/carea_logo.svg',
          width: MediaQuery.of(context).size.width / 5 * 2,
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.04),
        const Text(
          "Hello!\nThis is",
          style: titleTextStyle,
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Care a",
              style: careaTitleTextStyle,
            ),
            Text(
              "rea",
              style: titleTextStyle,
            ),
          ],
        ),
        const Text(
          "for you",
          style: titleTextStyle,
        ),
      ],
    );
  }
}
