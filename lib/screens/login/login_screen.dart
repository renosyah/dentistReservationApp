import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  void _validation(BuildContext context) {
    RegExp regExp = RegExp(_LoginScreenState.pattern);
    if (_controllerEmail.text.trim().isEmpty || !regExp.hasMatch(_controllerEmail.text)) {
      print("email invalid");
      return;
    }
    if (_controllerPassword.text.trim().isEmpty) {
      print("password invalid");
      return;
    }

    _login(context, _controllerEmail.text.toString(),_controllerPassword.text.toString());
  }

  void _login(BuildContext context,String email,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password );
      Navigator.pushReplacementNamed(context, home);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user not found");
        return;
      } else if (e.code == 'wrong-password') {
        print("password invalid");
        return;
      }
    }
  }

  User user;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    if (userData == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushReplacementNamed(context, home);
    });

  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

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
                          controller: _controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).emailHint,
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
                          controller: _controllerPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).passwordHint,
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
                    onPressed: () { this._validation(context); },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimary),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      AppLocalizations.of(context).btnLogin,
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
                      text: AppLocalizations.of(context).dontHaveAnAccountYet,
                      style: TextStyle(color: kText2, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: AppLocalizations.of(context).registerText,
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

