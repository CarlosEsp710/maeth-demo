import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:context_holder/context_holder.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/providers/chat_provider.dart';
import 'package:maeth_demo/src/providers/navigation_provider.dart';
import 'package:maeth_demo/src/providers/socket_provider.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/views/ui/loading_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Maeth DEMO',
        home: const LoadingView(),
        builder: (context, widget) {
          return ScrollConfiguration(
            behavior: const ScrollTheme(),
            child: widget!,
          );
        },
        navigatorKey: ContextHolder.key,
        theme: MaethTheme().appTheme(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
