import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dentistReservationApp/utils/theme.dart';
import 'package:dentistReservationApp/routing/routes.dart' as route;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: kBackground));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reservasi Dentist',
        theme: theme(),
        initialRoute: splash,
        onGenerateRoute: route.Routes.generateRoute);
  }
}
