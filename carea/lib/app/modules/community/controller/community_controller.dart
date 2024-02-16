import 'dart:convert' show json;
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// 게시글 카테고리별 목록 조회
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
      formattedUpdatedAt = formattedCreatedAt;
    }

    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      created_at: formattedCreatedAt,
      updated_at: formattedUpdatedAt,
      user: json['user'] as Object,
      nickname: json['user']['nickname'] as String,
    );
  }
}

class Posts {
  final Dio dio = Dio();
  late List<Post> _items;

  Posts() {
    _items = [];
  }

  List<Post> get items => _items;

  Future<void> fetchAndSetPosts(String boardId) async {
    List<String> categories = ['latest', 'free', 'life', 'economic', 'future'];
    for (String category in categories) {
      await _fetchPostsForCategory(category);
    }
  }

  Future<void> _fetchPostsForCategory(String category) async {
    String baseUrl = 'http://10.0.2.2:8000/posts/$category/';
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> extractedData = response.data;
        List<dynamic> result = extractedData['result'];
        final List<Post> loadedPosts = result.map((entry) {
          return Post.fromJson(entry);
        }).toList();
        _items.addAll(loadedPosts);
      } else {
        print('Failed to fetch posts for category $category');
      }
    } catch (error) {
      print('Error fetching posts for category $category: $error');
    }
  }
}

// 게시글 상세 조회

// 게시글 등록
