import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(270.0),
      height: getProportionateScreenHeight(56.0),
      child: ElevatedButton(
        onPressed: press,
        child: Ink(
          decoration: BoxDecoration(
              gradient: kPrimaryGradientColor,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(30.0))),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: getProportionateScreenWidth(300.0),
                minHeight: getProportionateScreenHeight(50.0)),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kBackGround,
                  fontSize: getProportionateScreenWidth(14.0),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
