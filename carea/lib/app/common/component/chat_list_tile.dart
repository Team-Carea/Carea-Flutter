import 'package:carea/app/data/models/chat_room_list_model.dart';
import 'package:carea/app/modules/chat/view/chat_room_screen.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoomInfo;

  const ChatRoomTile({super.key, required this.chatRoomInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(id: chatRoomInfo.id)),
            );
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(chatRoomInfo.opponent.profileUrl),
          ),
          title: Text(
            chatRoomInfo.opponent.nickname,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                chatRoomInfo.latestMessage!,
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
          trailing: const Text('02:18'),
        ),
        const Divider(
          thickness: 1,
          indent: 14,
          endIndent: 14,
        ),
      ],
    );
  }
}
