import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MaethTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xff01C573),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff1CE391),
        secondary: const Color(0xff1CE391),
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff01C473),
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 1,
      ),
    );
  }
}

class ScrollTheme extends ScrollBehavior {
  const ScrollTheme();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}

class MaethInputDecoration {
  InputDecoration textInputDecoration({
    required BuildContext context,
    String lableText = "",
    String hintText = "",
    bool suffixIcon = false,
    Widget? icon,
    double radius = 30.0,
  }) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      suffixIcon: (suffixIcon) ? icon : null,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xff1CE391)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xff1CE391)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }

  InputDecoration textReportDecoration({
    required BuildContext context,
    String lableText = "",
    String hintText = "",
    bool suffixIcon = false,
    Widget? icon,
    double radius = 10.0,
  }) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      suffixIcon: (suffixIcon) ? icon : null,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xff1CE391)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Color(0xff1CE391)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }
}
