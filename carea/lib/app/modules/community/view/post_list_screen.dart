import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/modules/community/view/create_post_screen.dart';
import 'package:carea/app/modules/community/view/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carea/app/modules/community/controller/community_controller.dart';

class PostListScreen extends StatefulWidget {
  final String pageTitle;

  const PostListScreen({Key? key, required this.pageTitle}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final Posts _posts = Posts();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    List<String> categories = ['latest', 'free', 'life', 'economic', 'future'];
    await _posts.fetchAndSetPosts('$categories');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = _posts.items;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: Center(
          child: Text(widget.pageTitle),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
        elevation: 0,
      ),
      body: DefaultLayout(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemCount: _posts.items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetail(
                              pageTitle: widget.pageTitle,
                            )),
                  );
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        post[index].title,
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
                            post[index].content,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                post[index].created_at,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                post[index].nickname,
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
                ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: AppColors.greenPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
