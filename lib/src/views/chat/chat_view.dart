import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:context_holder/context_holder.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/schemas/chat_response.dart';
import 'package:maeth_demo/src/providers/chat_provider.dart';
import 'package:maeth_demo/src/providers/socket_provider.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';

final _currentContext = ContextHolder.currentContext;
final _me = Provider.of<UserProvider>(_currentContext, listen: false).user;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatView extends StatefulWidget {
  final User user;

  const ChatView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  late ChatProvider chatProvider;
  late SocketProvider socketProvider;

  final List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    socketProvider = Provider.of<SocketProvider>(context, listen: false);

    socketProvider.socket.on('private-message', _listenMessage);

    _loadHistory(_me.id.toString());
  }

  void _loadHistory(String from) async {
    List<MessageModel> chat = await chatProvider.getChat(from, widget.user.id!);

    final history = chat.map(
      (m) => types.TextMessage(
        author: types.User(id: m.from),
        id: randomString(),
        text: m.message,
      ),
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    types.TextMessage message = types.TextMessage(
      author: types.User(id: payload['from']),
      createdAt: payload['createdAt'],
      id: randomString(),
      text: payload['message'],
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  final _user = types.User(
    id: _me.id!,
    firstName: _me.firstName,
    lastName: _me.lastName,
    imageUrl: _me.imageProfile,
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    socketProvider.emit('private-message', {
      'from': _me.id,
      'for': widget.user.id,
      'message': message.text,
    });
  }

  @override
  void dispose() {
    socketProvider.socket.off('private-message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chatBar(context),
      body: SafeArea(
        bottom: false,
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          theme: const DefaultChatTheme(
            inputBackgroundColor: Color(0xff4DC591),
            inputTextColor: Colors.white,
            inputTextCursorColor: Colors.white,
            inputMargin: EdgeInsets.all(8),
            inputBorderRadius: BorderRadius.all(Radius.circular(25)),
            primaryColor: Color(0xff05BD74),
            secondaryColor: Color(0xff00AA96),
            receivedMessageBodyTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _chatBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16, top: 5),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.imageProfile),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '${widget.user.firstName} ${widget.user.lastName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
