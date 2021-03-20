import 'package:flutter/material.dart';
import 'package:dentistReservationApp/splash/components/sections/creator_section.dart';
import 'package:dentistReservationApp/splash/components/sections/logo_section.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class SplashBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(160.0),
        ),
        LogoSection(),
        Spacer(),
        CreatorSection(),
        SizedBox(
          height: getProportionateScreenHeight(24.0),
        ),
        Align(
          alignment: Alignment.center,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
