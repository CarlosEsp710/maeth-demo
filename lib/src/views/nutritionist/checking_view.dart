import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

import 'package:maeth_demo/src/widgets/widgets.dart';

class CheckingView extends StatelessWidget {
  const CheckingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff109071),
            Color(0xff02c574),
            Color(0xff02c574),
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
                    'Verificando datos',
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
                    'assets/svg/undraw_logistics_x-4-dc.svg',
                    height: 350,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Estamos verificando tu información',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Por favor se paciente, pronto te enviaremos\n una notificación.',
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
                    text: 'Salir',
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
