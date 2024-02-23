import 'package:carea/app/common/component/category.dart';
import 'package:carea/app/common/const/app_colors.dart';
import "package:carea/app/common/layout/default_layout.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.pageTitle, this.comment});
  final String pageTitle;
  final String? comment;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  List<Comment> comments = generateDummyComments();
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
                    width: 5,
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('/asset/svg/icon/defaultimage.svg'),
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  final comment = comments[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage:
                              NetworkImage(comment.profileImageUrl),
                        ),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.authorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              comment.content,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              comment.timestamp.toString(),
                              // API 연동 시 created_at으로 변경
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ), // 댓글 입력 박스 고정 + body만 scrollview로 변경 필요
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
                          onChanged: (value) {
                            setState(() {});
                          },
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
                          onPressed: () {},
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
