import 'package:carea/app/modules/chat/view/chat_list_screen.dart';
import 'package:carea/app/modules/community/view/add_post.dart';
import 'package:carea/app/modules/community/view/community_screen.dart';
import 'package:carea/app/modules/nearhelp/view/nearhelp_screen.dart';
import 'package:carea/app/modules/user/view/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  errorPageBuilder: (context, state) =>
      const MaterialPage(child: Text('Error!')),
  routes: [
    GoRoute(
      path: '/community',
      builder: (context, state) => const CommunityScreen(),
      routes: [
        GoRoute(
          path: '/addpost',
          builder: (context, state) => const AddPost(),
        ),
      ],
    ),
    GoRoute(
      path: '/chatlist',
      builder: (context, state) => const ChatlistScreen(),
    ),
    GoRoute(
      path: '/nearhelp',
      builder: (context, state) => const NearhelpScreen(),
    ),
    GoRoute(
      path: '/mypage',
      builder: (context, state) => const MypageScreen(),
    ),
  ],
);
