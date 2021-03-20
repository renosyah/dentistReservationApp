import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackGround,
    fontFamily: "Poppins",
    primaryColor: kPrimaryColor,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: kSubtitleTextColor),
    gapPadding: 16,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTitleTextColor),
    bodyText2: TextStyle(color: kSubtitleTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kBackGround,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kSubtitleTextColor),
  );
}
