import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: getProportionateScreenHeight(36.0)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(136.0),
              ),
              Image.asset(
                "assets/logo/logo.png",
                width: getProportionateScreenWidth(160.0),
                height: getProportionateScreenWidth(160.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(96.0),
              ),
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: emailHint,
                        filled: true,
                        fillColor: kBackgroundTextField,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(36.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: passwordHint,
                        filled: true,
                        fillColor: kBackgroundTextField,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  )
                ],
              )),
              SizedBox(
                height: getProportionateScreenHeight(120.0),
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
                        Navigator.pushReplacementNamed(context, home),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimary),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      btnLogin,
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
                height: getProportionateScreenHeight(36.0),
              ),
              RichText(
                  text: TextSpan(
                      text: dontHaveAnAccountYet,
                      style: TextStyle(color: kText2, fontSize: 16.0),
                      children: [
                    TextSpan(
                        text: registerText,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: kPrimary,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.pushReplacementNamed(context, register))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
