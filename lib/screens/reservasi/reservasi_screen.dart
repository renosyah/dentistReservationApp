import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReservasiScreen extends StatelessWidget {
  static final data = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          navBarTextReservasi,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: data
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 8,
                            spreadRadius: 4,
                            offset: Offset(0.0, 0.0),
                            color: kText1.withOpacity(0.1))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(nameHint,
                            style: TextStyle(fontSize: 14.0, color: kText2)),
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          "Suparmin",
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(24.0),
                        ),
                        Text(emailHint,
                            style: TextStyle(fontSize: 14.0, color: kText2)),
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          "reservasi@gmail.com",
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(24.0),
                        ),
                        Text(time,
                            style: TextStyle(fontSize: 14.0, color: kText2)),
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          "03:00 PM",
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(24.0),
                        ),
                        Text(queueNumber,
                            style: TextStyle(fontSize: 14.0, color: kText2)),
                        SizedBox(height: getProportionateScreenWidth(56.0)),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "09",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 56.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(56.0),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            note,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kText2, fontSize: 12.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : EmptyReservasi(),
    );
  }
}

class EmptyReservasi extends StatelessWidget {
  const EmptyReservasi({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenWidth(112.0),
        ),
        Center(
            child: SvgPicture.asset(
          "assets/illustrations/emptyreservasi.svg",
          width: getProportionateScreenWidth(140),
        )),
        SizedBox(
          height: getProportionateScreenHeight(56.0),
        ),
        Center(
            child: Text(
          emptyReservasiTitle,
          style: TextStyle(
              color: kText1, fontWeight: FontWeight.bold, fontSize: 18.0),
        )),
        SizedBox(
          height: getProportionateScreenHeight(24.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(36.0)),
          child: Center(
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: emptyReservasiSubtitle,
                    style: TextStyle(fontSize: 16.0, color: kText2),
                    children: [
                      TextSpan(
                          text: navBarTextHome,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: kPrimary,
                              fontWeight: FontWeight.bold))
                    ])),
          ),
        )
      ],
    );
  }
}
