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
  final Posts _posts = Posts();
  final Comments _comments = Comments();

  Future<Post?> _fetchPost() async {
    try {
      final post = await _posts.getPostDetail(widget.id);
      return post;
    } catch (error) {
      return null;
    }
  }

  Future<List<Object>> _fetchComments() async {
    try {
      final comments = await _comments.fetchComments(widget.id.toString());
      return comments;
    } catch (error) {
      return [];
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
      body: DefaultLayout(
        child: FutureBuilder<Post?>(
          future: _fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading post'));
            } else if (snapshot.data == null) {
              return const Center(child: Text('해당 포스트에 대한 정보가 없습니다다'));
            } else {
              final Post post = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: DefaultLayout(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 30),
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(post.profileUrl),
                                    radius: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.nickname,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    post.created_at,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.title,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.content,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const Divider(),
                          const PostReactions(),
                          const SizedBox(height: 10),
                          FutureBuilder<List<Object>>(
                            future: _fetchComments(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text('Error loading comments');
                              } else {
                                final List<Object> comments =
                                    snapshot.data ?? [];
                                return Comment(comments: comments);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const CommentMaker(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class PostReactions extends StatelessWidget {
  const PostReactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.comments,
  });

  final List<Object> comments;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
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
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundColor: AppColors.bluePrimaryColor,
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        comment.toString(),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        comment.toString(),
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
    );
  }
}

class CommentMaker extends StatelessWidget {
  const CommentMaker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
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
    );
  }
}
