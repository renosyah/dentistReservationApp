import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class SubtitleSection extends StatelessWidget {
  const SubtitleSection({
    Key key,
    @required this.subtitle,
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(270.0),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: getProportionateScreenWidth(18.0),
            color: kSubtitleTextColor),
      ),
    );
  }
}
