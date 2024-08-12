import 'dart:convert';

class Users {
  final String uid;
  final String name;
  final String keyName;
  final String email;
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final String photoUrl;
  final String status;
  final DateTime updatedTime;
  final List<Chat> chats;

  Users({
    required this.uid,
    required this.name,
    required this.keyName,
    required this.email,
    required this.creationTime,
    required this.lastSignInTime,
    required this.photoUrl,
    required this.status,
    required this.updatedTime,
    required this.chats,
  });

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        name: json["name"],
        keyName: json["keyName"],
        email: json["email"],
        creationTime: DateTime.parse(json["creationTime"]),
        lastSignInTime: DateTime.parse(json["lastSignInTime"]),
        photoUrl: json["photoUrl"],
        status: json["status"],
        updatedTime: DateTime.parse(json["updatedTime"]),
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "keyName": keyName,
        "email": email,
        "creationTime": creationTime.toIso8601String(),
        "lastSignInTime": lastSignInTime.toIso8601String(),
        "photoUrl": photoUrl,
        "status": status,
        "updatedTime": updatedTime.toIso8601String(),
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
      };
}

class Chat {
  final String connection;
  final String chatId;
  final DateTime lastTime;
  final int totalUnread;

  Chat({
    required this.connection,
    required this.chatId,
    required this.lastTime,
    required this.totalUnread,
  });

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: DateTime.parse(json["lastTime"]),
        totalUnread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime.toIso8601String(),
        "total_unread": totalUnread,
      };
}
