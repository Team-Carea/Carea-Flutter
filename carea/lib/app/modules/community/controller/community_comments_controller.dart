import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

final Dio dio = Dio();

class Comment {
  int id;
  int postId;
  String content;
  String created_at;
  Object user;
  String nickname;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.created_at,
    required this.user,
    required this.nickname,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['created_at']);
    String formattedCreatedAt = DateFormat('yyyy-MM-dd').format(createdAt);

    return Comment(
      id: json['id'],
      postId: json['post_id'],
      content: json['content'],
      created_at: formattedCreatedAt,
      user: json['user'],
      nickname: json['user']['nickname'],
    );
  }
}

// 댓글 출력

class Comments {
  late List<Comment> _items;

  Comments() {
    _items = [];
    _items.sort((a, b) {
      return b.created_at.compareTo(a.created_at);
    });
  }

  List<Comment> get items => _items;

  Future<void> getCommentDetail(String postId) async {
    String baseUrl = 'http://10.0.2.2:8000/posts/$postId/comments/';
    try {
      final response = await dio.get(baseUrl);
      print(response);
      if (response.statusCode == 200) {
        Map<String, dynamic> extractedData = response.data;
        List<dynamic> result = extractedData['result'];
        final List<Comment> loadedComments = result.map((entry) {
          return Comment.fromJson(entry);
        }).toList();
        _items.addAll(loadedComments);
      } else {
        print('Failed to fetch comments');
      }
    } catch (error) {
      print('$error');
    }
  }
}

// 댓글 등록

Future<void> postComment(
    int postId, String content, String userNickname) async {
  try {
    final response = await dio.post(
      'http://10.0.2.2:8000/posts/$postId/comments/',
      data: {
        'post_id': postId,
        'content': content,
        'user': {
          'nickname': userNickname,
        },
      },
    );
    if (response.statusCode == 201) {
      final jsonbody = response.data['result'];
      print(jsonbody);
      return;
    } else {
      throw Exception('Failed to post comment');
    }
  } catch (error) {
    throw Exception('Failed to post comment: $error');
  }
}
