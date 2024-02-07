import 'package:carea/app/common/component/board_button.dart';
import 'package:carea/app/common/component/bottom_bar.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          '커뮤니티',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {
                context.go('/mypage');
              },
              icon: const Icon(Icons.person_2_outlined))
        ],
        backgroundColor: AppColors.greenPrimaryColor,
        elevation: 0,
      ),
      body: DefaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            BoardButton(
                onPressed: () {
                  context.push('/community/newest');
                },
                text: '최신글'),
            const SizedBox(
              height: 20,
            ),
            BoardButton(
                onPressed: () {
                  context.push('/free');
                },
                text: '자유 게시판'),
            const SizedBox(
              height: 20,
            ),
            BoardButton(
                onPressed: () {
                  context.push('/economy');
                },
                text: '경제/금융'),
            const SizedBox(
              height: 20,
            ),
            BoardButton(
                onPressed: () {
                  context.push('/lifestyle');
                },
                text: '생활'),
            const SizedBox(
              height: 20,
            ),
            BoardButton(
                onPressed: () {
                  context.push('/vision');
                },
                text: '진로'),
            const RootTab()
          ],
        ),
      ),
    );
  }
}
