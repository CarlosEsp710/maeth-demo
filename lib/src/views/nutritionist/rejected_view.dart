import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

import 'package:maeth_demo/src/widgets/widgets.dart';

class RejectedView extends StatelessWidget {
  const RejectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff420606),
            Color(0xa5ff0a0a),
            Color(0xa5ff0a0a),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Lo sentimos, tu perfil no ha sido aprovado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SvgPicture.asset(
                    'assets/svg/undraw_access_denied_re_awnf.svg',
                    height: 350,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Verifica tu información',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'No cumples los requisitos necesarios para acceder a la aplicación.Si necesitas ayuda contacta a nuestro soporte. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  GFButton(
                    onPressed: () => {},
                    text: 'Volver a intentar',
                    color: Colors.white,
                    textColor: Colors.black,
                    fullWidthButton: true,
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                  ),
                  const SizedBox(height: 50),
                  const LogoUnicla(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
