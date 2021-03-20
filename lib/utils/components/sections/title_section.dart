import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: getProportionateScreenWidth(24.0),
          color: kTitleTextColor),
    );
  }
}
