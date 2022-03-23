import 'dart:convert';

AuthErrorResponse authErrorResponseFromJson(String str) =>
    AuthErrorResponse.fromJson(json.decode(str));

String authErrorResponseToJson(AuthErrorResponse data) =>
    json.encode(data.toJson());

class AuthErrorResponse {
  AuthErrorResponse({
    required this.errors,
  });

  List<Error> errors;

  factory AuthErrorResponse.fromJson(Map<String, dynamic> json) =>
      AuthErrorResponse(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    required this.status,
    required this.title,
    required this.detail,
  });

  String status;
  String title;
  String detail;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        status: json["status"],
        title: json["title"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "title": title,
        "detail": detail,
      };
}
