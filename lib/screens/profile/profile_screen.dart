import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            navBarTextProfile,
            style: TextStyle(
                color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(24.0),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logo/logo.png",
                  width: getProportionateScreenWidth(120.0),
                  height: getProportionateScreenWidth(120.0),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              Text(
                "Suparmin",
                style: TextStyle(
                    color: kText1, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              Text(
                "reservasi@gmail.com",
                style: TextStyle(color: kText2, fontSize: 18.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, about),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
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
                      children: [
                        Text(
                          aboutApp,
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          aboutAppDesc,
                          style: TextStyle(color: kText2, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(24.0),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, help),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
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
                      children: [
                        Text(
                          helpApp,
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          helpAppDesc,
                          style: TextStyle(color: kText2, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(56.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double.infinity,
                      height: getProportionateScreenHeight(72.0)),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, login),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimary),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      btnLogout,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(24.0),
              ),
            ],
          ),
        ));
  }
}
