import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dentistReservationApp/utils/size_config.dart';

class IllustrationSection extends StatelessWidget {
  const IllustrationSection({
    Key key,
    @required this.asset,
  }) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        asset,
        width: getProportionateScreenWidth(120.0),
        height: getProportionateScreenHeight(120.0),
      ),
    );
  }
}
