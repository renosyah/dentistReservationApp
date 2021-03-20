import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/logo/logo.png",
            width: getProportionateScreenWidth(96.0),
            height: getProportionateScreenHeight(96.0),
          ),
          SizedBox(
            height: getProportionateScreenHeight(24.0),
          ),
          Text(
            "Legend Coffeeeee",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(22.0),
              foreground: Paint()..shader = kGradientTextColor,
            ),
          )
        ],
      ),
    );
  }
}
