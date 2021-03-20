import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dentistReservationApp/routing/constanta_routing.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/theme.dart';
import 'package:dentistReservationApp/routing/routes.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: kBackGround));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reservasi Dentist',
        theme: theme(),
        initialRoute: splash,
        onGenerateRoute: route.Routes.generateRoute);
  }
}
