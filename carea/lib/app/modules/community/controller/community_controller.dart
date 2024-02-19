import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

final Dio dio = Dio();

class Post {
  int id;
  String title;
  String content;
  String category;
  String created_at;
  String? updated_at;
  Object user;
  String nickname;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.created_at,
    this.updated_at,
    required this.user,
    required this.nickname,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['created_at']);
    String formattedCreatedAt = DateFormat('yyyy-MM-dd').format(createdAt);
    String? formattedUpdatedAt;

    if (json['updated_at'] != null) {
      DateTime updatedAt = DateTime.parse(json['updated_at']);
      formattedUpdatedAt = DateFormat('yyyy-MM-dd').format(updatedAt);
    } else {
      String formattedUpdatedAt = formattedCreatedAt;
    }

    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      created_at: formattedCreatedAt,
      updated_at: formattedUpdatedAt,
      user: json['user'],
      nickname: json['user']?['nickname'] ?? "undefined",
    );
  }
}

class Posts {
  final List<Post> _items = [];

  List<Post> get items => _items;

  Future<void> fetchAndSetPosts(String category) async {
    _items.clear();

    if (category.isEmpty) {
      List<String> categories = [
        'latest',
        'free',
        'life',
        'economic',
        'future'
      ];
      await Future.wait(
          categories.map((category) => _fetchPostsForCategory(category)));
    } else {
      await _fetchPostsForCategory(category);
    }

    _items.sort((a, b) => b.created_at.compareTo(a.created_at));
  }

  Future<void> _fetchPostsForCategory(String category) async {
    String baseUrl = 'http://10.0.2.2:8000/posts/$category/';
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<dynamic> result = response.data['result'];
        final List<Post> loadedPosts =
            result.map((entry) => Post.fromJson(entry)).toList();
        _items.addAll(loadedPosts);
        print(_items);
      } else {
        print('Failed to fetch posts for category $category');
      }
    } catch (error) {
      print('Error fetching posts for category $category: $error');
    }
  }

// 게시글 상세 조회

  Future<Post?> getPostDetail(int id) async {
    String baseUrl = 'http://10.0.2.2:8000/posts/$id/';
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> extractedData = response.data;
        print(extractedData);
        return Post.fromJson(extractedData);
      } else {
        print('Failed to fetch post with id $id');
        return null;
      }
    } catch (error) {
      print('Error fetching post with id $id: $error');
      return null;
    }
  }
}

// 게시글 등록

Future<void> createPost(String title, String content, String category) async {
  String baseUrl = 'http://10.0.2.2:8000/posts/$category/';
  try {
    final response = await dio.post(
      baseUrl,
      data: {
        'title': title,
        'content': content,
        'category': category,
        'user': 1,
      },
    );
    if (response.statusCode == 201) {
      print('게시글이 성공적으로 작성되었습니다.');
    } else {
      print('게시글 작성에 실패했습니다. 오류 코드: ${response.statusCode}');
    }
  } catch (error) {
    print('게시글 작성 중 오류가 발생했습니다: $error');
  }
}
