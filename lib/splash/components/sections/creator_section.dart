import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class CreatorSection extends StatelessWidget {
  const CreatorSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        "Made By\n Robi Dahariansyah",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(14.0),
          foreground: Paint()..shader = kGradientTextColor,
        ),
      ),
    );
  }
}
