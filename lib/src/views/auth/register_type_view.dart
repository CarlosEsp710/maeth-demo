import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';

import 'package:maeth_demo/src/views/auth/login_view.dart';
import 'package:maeth_demo/src/views/auth/register_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class RegisterTypeView extends StatelessWidget {
  const RegisterTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GFButton(
                  onPressed: () => _navigate(context, 'Nutriólogo'),
                  text: 'Registrarme como nutriólogo',
                  color: const Color(0xff01C473),
                  textColor: Colors.white,
                  fullWidthButton: true,
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                ),
                const SizedBox(height: 20),
                GFButton(
                  onPressed: () => _navigate(context, 'Paciente'),
                  text: 'Registrarme como paciente',
                  color: const Color(0xffFF6B37),
                  textColor: Colors.white,
                  fullWidthButton: true,
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                ),
                const SizedBox(height: 50),
                const Labels(
                  route: const LoginView(),
                  title: 'Ya tienes una cuenta?',
                  subtitle: 'Inicia sesión',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigate(BuildContext context, String type) => Navigator.push(
        context,
        PageTransition(
          child: RegisterView(type: type),
          type: PageTransitionType.rightToLeft,
        ),
      );
}
