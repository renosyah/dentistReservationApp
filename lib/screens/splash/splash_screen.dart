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
  // waktu delay yakni 4 detik
  final splashDelay = 4;

  @override
  void initState() {
    super.initState();
    // fungsi _loadwidget akan dijalankan saat aplikasi pertama kali dibuka
    _loadWidget();
  }

  // fungsi _loadwidget
  _loadWidget() {
    // variable durasi diisi dengan pnajang durasi splash
    var _duration = Duration(seconds: splashDelay);
    // kembalikan durasi serta jalankan fungsi navigationPage
    return Timer(_duration, navigationPage);
  }

  // fungsi navigationPage
  void navigationPage() {
    // arahkan ke halaman login
    Navigator.pushReplacementNamed(context, login);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        // memberi jarak dikiri dan kanan elemen
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        // menampilkan lemen secara vertical
        child: Column(
          children: [
            // membuat jarak antar elemen menggunkan spacer
            Spacer(),
            // menampilkan logo aplikasi
            Align(
              // menempatkan logo berada ditengah
              alignment: Alignment.center,
              child: Image.asset(
                // menampilkan logo
                "assets/logo/logo.png",
                width: getProportionateScreenWidth(200.0), // panjang logo
                height: getProportionateScreenWidth(200.0), // tinggi logo
              ),
            ),
            // membuat jarak antar elemen menggunkan spacer
            Spacer(),
            // menampilkan identitas pemilik aplikasi
            Align(
              // menempatkan text berada ditengah
              alignment: Alignment.center,
              child: RichText(
                // text berada ditengah
                textAlign: TextAlign.center,
                text: TextSpan(
                    // menampilkan pemilik aplikasi
                    text: AppLocalizations.of(context).developer,
                    style: TextStyle(
                        fontSize: 20.0, //memberi ukuran text
                        fontWeight: FontWeight.bold, // memberi ketebalan text
                        color: kPrimary), // memberi warna text
                    children: [
                      TextSpan(
                          // menampilkan nim pemilik aplikasi
                          text: AppLocalizations.of(context).nim,
                          style: TextStyle(
                              fontSize: 16.0, // memberi ukuran text
                              fontWeight:
                                  FontWeight.bold, // memberi ketebelan text
                              color: kPrimary)) // memberi warna text
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
