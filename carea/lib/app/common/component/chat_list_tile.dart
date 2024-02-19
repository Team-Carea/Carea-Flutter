import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        radius: 25,
      ),
      title: Text(
        '신진영',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            '정현아... 자니..?',
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
      trailing: Text('02:18'),
    );
  }
}
