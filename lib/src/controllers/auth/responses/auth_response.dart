import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authErrorResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    required this.userId,
    required this.plainTextToken,
  });

  String userId;
  String plainTextToken;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["user_id"],
        plainTextToken: json["plain-text-token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "plain-text-token": plainTextToken,
      };
}
