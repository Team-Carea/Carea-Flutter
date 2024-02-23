import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: '다양한 카테고리를 통해 \n정보와 지식을 공유해보세요!',
            body: '생활, 경제, 진로 등 다양한 주제에 맞춰 \n게시글을 작성해보세요',
            image: Image.asset(
              'asset/img/board.png',
            ),
          ),
          PageViewModel(
              title: '내 주위에 누가 도움을 \n요청하는 지 살펴볼 수 있어요.',
              body: '도움이 필요하다면 도움을 등록할 수 있어요',
              image: Image.asset(
                'asset/img/nearhelp.png',
                alignment: Alignment.bottomCenter,
              ),
              decoration: const PageDecoration()),
          PageViewModel(
              title: '채팅을 통해 비대면 도움을 \n받을 수 있습니다.',
              body: '채팅방에서 받았던 도움들을 다시 읽어볼 수 있어요',
              // image: Image.asset(''),
              decoration: const PageDecoration()),
          PageViewModel(
              title: '채팅을 통해 약속을 잡아 \n대면 도움을 받을 수 있습니다.',
              body: '캐리아의 다양한 기능을 소개합니다',
              // image: Image.asset(''),
              decoration: const PageDecoration()),
          PageViewModel(
              title: '인증을 통해 경험치를 쌓아 \n레벨을 올려보세요.',
              body: '도움도 받고 인증도 하며 \n인생의 경험치도 함께 키워보세요',
              // image: Image.asset(''),
              decoration: const PageDecoration()),
        ],
        done: const Text('done',
            style: TextStyle(color: AppColors.yellowPrimaryColor)),
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RootTab()),
          );
        },
        next: const Icon(
          Icons.arrow_forward,
          color: AppColors.yellowPrimaryColor,
        ),
        showSkipButton: true,
        skip: const Text(
          'skip',
          style: TextStyle(color: AppColors.yellowPrimaryColor),
        ),
        dotsDecorator: DotsDecorator(
            color: AppColors.greenPrimaryColor,
            size: const Size(10, 10),
            activeSize: const Size(22, 10),
            activeShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            activeColor: AppColors.yellowPrimaryColor),
        curve: Curves.bounceOut,
        dotsFlex: 4,
      ),
    );
  }
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
    bodyAlignment: Alignment.centerLeft,
    titleTextStyle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 22,
      color: AppColors.black,
    ),
    imagePadding: EdgeInsets.only(top: 70),
    pageColor: AppColors.white,
  );
}
