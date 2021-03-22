import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackground,
    fontFamily: "Poppins",
    primaryColor: kPrimary,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: kBackgroundTextField,
    contentPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(24.0),
        vertical: getProportionateScreenWidth(16.0)),
    border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(8.0))),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kText1),
    bodyText2: TextStyle(color: kText2),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kBackground,
    elevation: 0,
    centerTitle: true,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kPrimary),
  );
}
