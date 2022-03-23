import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/auth/login_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/views/auth/register_type_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                LogoMaeth(color: Color(0xff01C473)),
                _Form(),
                Labels(
                  route: RegisterTypeView(),
                  title: '¿No tienes una cuenta?',
                  subtitle: 'Regístrate!',
                ),
                LogoUnicla(color: Color(0xff132E4D)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: _loginController.loginFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _loginController.emailController,
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Email',
                hintText: 'Ingresa tu email',
              ),
              validator: (value) => Validator().validateEmail(value!),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _loginController.passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Contraseña',
                hintText: 'Ingresa tu contraseña',
              ),
              validator: (value) => Validator().validatePassword(value!),
            ),
            const SizedBox(height: 30),
            GFButton(
              onPressed: () => _loginController.login(context),
              text: 'Iniciar sesión',
              color: const Color(0xff01C473),
              textColor: Colors.white,
              fullWidthButton: true,
              shape: GFButtonShape.pills,
              size: GFSize.LARGE,
            ),
          ],
        ),
      ),
    );
  }
}
