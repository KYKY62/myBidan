import 'dart:convert';

class BidanModel {
  final String? uid;
  final String? name;
  final String? keyName;
  final String? email;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final String? photoBidan;
  final String? status;
  final DateTime? jamAwalKerja;
  final DateTime? jamAkhirKerja;
  final DateTime? updatedTime;
  final String? role;
  List<ChatsBidan>? chatsBidan;

  BidanModel({
    this.uid,
    this.name,
    this.keyName,
    this.email,
    this.creationTime,
    this.lastSignInTime,
    this.photoBidan,
    this.status,
    this.jamAwalKerja,
    this.jamAkhirKerja,
    this.updatedTime,
    this.role,
    this.chatsBidan,
  });

  factory BidanModel.fromRawJson(String str) =>
      BidanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BidanModel.fromJson(Map<String, dynamic> json) => BidanModel(
        uid: json["uid"],
        name: json["name"],
        keyName: json["keyName"],
        email: json["email"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        lastSignInTime: json["lastSignInTime"] == null
            ? null
            : DateTime.parse(json["lastSignInTime"]),
        photoBidan: json["photoBidan"],
        status: json["status"],
        jamAwalKerja: json["jamAwalKerja"] == null
            ? null
            : DateTime.parse(json["jamAwalKerja"]),
        jamAkhirKerja: json["jamAkhirKerja"] == null
            ? null
            : DateTime.parse(json["jamAkhirKerja"]),
        updatedTime: json["updatedTime"] == null
            ? null
            : DateTime.parse(json["updatedTime"]),
        role: json["role"],
        chatsBidan: json["chatsBidan"] == null
            ? []
            : List<ChatsBidan>.from(
                json["chatsBidan"]!.map((x) => ChatsBidan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "keyName": keyName,
        "email": email,
        "creationTime": creationTime?.toIso8601String(),
        "lastSignInTime": lastSignInTime?.toIso8601String(),
        "photoBidan": photoBidan,
        "status": status,
        "jamAwalKerja": jamAwalKerja?.toIso8601String(),
        "jamAkhirKerja": jamAkhirKerja?.toIso8601String(),
        "updatedTime": updatedTime?.toIso8601String(),
        "role": role,
        "chatsBidan": chatsBidan == null
            ? []
            : List<dynamic>.from(chatsBidan!.map((x) => x.toJson())),
      };
}

class ChatsBidan {
  final String? connection;
  final String? chatId;
  final String? lastTime;
  final int? totalUnread;

  ChatsBidan({
    this.connection,
    this.chatId,
    this.lastTime,
    this.totalUnread,
  });

  factory ChatsBidan.fromRawJson(String str) =>
      ChatsBidan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatsBidan.fromJson(Map<String, dynamic> json) => ChatsBidan(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: json["lastTime"],
        totalUnread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": totalUnread,
      };
}
