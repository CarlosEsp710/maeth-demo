import 'dart:convert';

ChatResponse chatResponseFromJson(String str) =>
    ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  ChatResponse({
    required this.ok,
    required this.messages,
  });

  bool ok;
  List<MessageModel> messages;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        ok: json["ok"],
        messages: List<MessageModel>.from(
            json["messages"].map((x) => MessageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class MessageModel {
  MessageModel({
    required this.from,
    required this.messageFor,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String messageFor;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        from: json["from"],
        messageFor: json["for"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "for": messageFor,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
