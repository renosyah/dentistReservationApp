import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/screens/about/about_screen.dart';
import 'package:dentistReservationApp/screens/help/help_screen.dart';
import 'package:dentistReservationApp/screens/home/home_screen.dart';
import 'package:dentistReservationApp/screens/login/login_screen.dart';
import 'package:dentistReservationApp/screens/register/register_screen.dart';
import 'package:dentistReservationApp/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// kumpulan navigation dari constanta.dart
class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case help:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      case createReservation:
        return MaterialPageRoute(builder: (_) => CreateReservationScreen());
      case promo:
        return MaterialPageRoute(builder: (_) => PromoScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
