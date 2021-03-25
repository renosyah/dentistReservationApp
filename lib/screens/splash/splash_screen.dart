import 'dart:async';

import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 4;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, login);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        child: Column(
          children: [
            Spacer(),
            // menampilkan logo aplikasi
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/logo/logo.png",
                width: getProportionateScreenWidth(200.0),
                height: getProportionateScreenWidth(200.0),
              ),
            ),
            Spacer(),
            // menampilkan identitas pemilik aplikasi
            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: AppLocalizations.of(context).developer,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimary),
                    children: [
                      TextSpan(
                          text: AppLocalizations.of(context).nim,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimary))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
