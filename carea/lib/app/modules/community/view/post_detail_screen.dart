import 'package:carea/app/common/const/app_colors.dart';
import "package:carea/app/common/layout/default_layout.dart";
import 'package:carea/app/modules/community/controller/community_controller.dart';
import 'package:carea/app/modules/community/controller/community_comments_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({
    Key? key,
    required this.pageTitle,
    required this.id,
  }) : super(key: key);

  final String pageTitle;
  final int id;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late Post _post;
  late final Posts _posts = Posts();
  late final Comments _comments = Comments();

  @override
  void initState() {
    super.initState();
    _getPostDetail();
    _getComments();
  }

  Future<void> _getPostDetail() async {
    try {
      final post = await _posts.getPostDetail(widget.id);
      if (post != null && mounted) {
        setState(() {
          _post = post;
        });
      } else {
        print('Post not found or error occurred');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getComments() async {
    await _comments.getCommentDetail(widget.id.toString());
    if (mounted) {
      setState(() {});
    }
  }

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DefaultLayout(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '/asset/svg/icon/defaultimage.svg'),
                            radius: 20,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _post.nickname,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _post.created_at,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _post.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _post.content,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.ellipses_bubble,
                              color: Colors.green,
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
                            const Text('4'),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _comments.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comment = _comments.items[index];
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
                              const CircleAvatar(
                                radius: 20.0,
                                backgroundColor: AppColors.bluePrimaryColor,
                              ),
                              const SizedBox(width: 12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.nickname,
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
                                    comment.created_at,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                        // Handle change
                      },
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력해주세요',
                        border: InputBorder.none,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    width: 40,
                    decoration: const ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle send
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
    );
  }
}
