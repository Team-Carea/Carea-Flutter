import 'package:carea/app/common/component/board_button.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/modules/community/view/post_list.dart';
import 'package:carea/app/modules/user/view/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/component/category.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MypageScreen()),
                );
              },
              icon: const Icon(Icons.person_2_outlined))
        ],
        elevation: 0,
      ),
      body: DefaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: category.length,
                itemBuilder: (BuildContext context, int index) {
                  return BoardButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostListScreen(
                                    pageTitle: '${category[index]['text']}')));
                      },
                      text: '${category[index]['text']}');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
