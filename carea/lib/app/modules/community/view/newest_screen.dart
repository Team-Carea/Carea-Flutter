import 'package:carea/app/common/component/bottom_bar.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Post {
  final String title;
  final String content;
  final String timestamp;
  final String author;

  Post(this.title, this.content, this.timestamp, this.author);
}

class NewestScreen extends StatefulWidget {
  const NewestScreen({Key? key}) : super(key: key);

  @override
  State<NewestScreen> createState() => _NewestScreenState();
}

class _NewestScreenState extends State<NewestScreen> {
  final List<Post> posts = List.generate(
    15,
    (index) => Post(
      "게시글 ${index + 1}",
      "게시글 내용입니다.",
      '13:42',
      '젤리',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: const Center(
          child: Text('최신글'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: AppColors.greenPrimaryColor,
        elevation: 0,
      ),
      body: DefaultLayout(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    posts[index].title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        posts[index].content,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            posts[index].timestamp,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            posts[index].author,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addpost');
        },
        backgroundColor: AppColors.greenPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
