import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:maeth_demo/src/schemas/chat_response.dart';

class ChatProvider with ChangeNotifier {
  Future getChat(String from, String to) async {
    try {
      final uri = Uri.parse(
          'https://cryptic-beach-70285.herokuapp.com/api/messages/$from/$to');

      final response = await http.get(uri, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      final chatResponse = chatResponseFromJson(response.body);

      return chatResponse.messages;
    } catch (e) {
      return [];
    }
  }
}
