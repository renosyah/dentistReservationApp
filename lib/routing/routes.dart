import 'package:flutter/material.dart';
import 'package:dentistReservationApp/home/home_screen.dart';
import 'package:dentistReservationApp/routing/constanta_routing.dart';
import 'package:dentistReservationApp/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
