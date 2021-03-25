import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/screens/about/about_screen.dart';
import 'package:dentistReservationApp/screens/help/help_screen.dart';
import 'package:dentistReservationApp/screens/home/home_screen.dart';
import 'package:dentistReservationApp/screens/login/login_screen.dart';
import 'package:dentistReservationApp/screens/promo/promo_screen.dart';
import 'package:dentistReservationApp/screens/register/register_screen.dart';
import 'package:dentistReservationApp/screens/reservasi/create_reservation/create_reservation_screen.dart';
import 'package:dentistReservationApp/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// kumpulan navigation dari constanta.dart
class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // navigasi ke halaman home
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // navigasi ke halaman login
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // navigasi ke halaman register
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      // navigasi ke halaman about
      case about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      // navigasi ke halaman help
      case help:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      // navigasi ke halaman buat reservasi
      case createReservation:
        return MaterialPageRoute(builder: (_) => CreateReservationScreen());
      // navigasi ke halaman promo
      case promo:
        return MaterialPageRoute(builder: (_) => PromoScreen());
      // navigasi ke halaman splash
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
