import 'package:flutter/material.dart';

import 'package:maeth_demo/src/controllers/auth/auth_manager_controller.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthManagerController controller = AuthManagerController();
    return Scaffold(
      body: FutureBuilder(
        future: controller.isLoggedIn(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/background_home.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                SizedBox(height: 100),
                LogoMaeth(),
                Spacer(flex: 2),
                LogoUnicla(),
              ],
            ),
          );
        },
      ),
    );
  }
}
