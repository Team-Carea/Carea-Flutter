import 'package:carea/app/common/const/app_colors.dart';
import "package:carea/app/common/layout/default_layout.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.pageTitle});
  final String pageTitle;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left_outlined,
              color: Colors.black),
        ),
        title: Text(
          widget.pageTitle,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined, color: Colors.black),
          )
        ],
      ),
      body: DefaultLayout(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('/asset/svg/icon/defaultimage.svg'),
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '캐리아짱',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '13:27',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '안녕 얘들아 ~~~~',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '이건 게시글 내용이얌~~~',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(),
              Row(
                children: [
                  const Row(
                    children: [
                      Icon(
                        CupertinoIcons.ellipses_bubble,
                        color: AppColors.greenPrimaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text('2'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4',
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      const Text('5'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                '댓글',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: '댓글을 입력해주세요',
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        width: 40,
                        decoration: const ShapeDecoration(
                          color: AppColors.greenPrimaryColor,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // 댓글 등록 API
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
