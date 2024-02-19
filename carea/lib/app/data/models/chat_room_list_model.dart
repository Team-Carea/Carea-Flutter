class ChatRoomList {
  final List<ChatRoom> chatRooms;

  ChatRoomList({required this.chatRooms});

  factory ChatRoomList.fromJson(List<Map<String, dynamic>> json) {
    List<ChatRoom> chatRoomList =
        json.map((i) => ChatRoom.fromJson(i)).toList();
    return ChatRoomList(chatRooms: chatRoomList);
  }
}

class ChatRoom {
  final int id;
  final int help;
  final String? latestMessage;
  final Opponent opponent;

  ChatRoom(
      {required this.id,
      required this.help,
      this.latestMessage,
      required this.opponent});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      help: json['help'],
      latestMessage: json['latest_message'],
      opponent: Opponent.fromJson(json['opponent']),
    );
  }
}

class Opponent {
  final int id;
  final String nickname;
  final String profileUrl;

  Opponent(
      {required this.id, required this.nickname, required this.profileUrl});

  factory Opponent.fromJson(Map<String, dynamic> json) {
    return Opponent(
      id: json['id'],
      nickname: json['nickname'],
      profileUrl: json['profile_url'] ?? "", // 프로필 URL이 null일 경우 빈 문자열로 처리
    );
  }
}
