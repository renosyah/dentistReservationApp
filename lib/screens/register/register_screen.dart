import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  void _validation(BuildContext context) {

    if (_controllerName.text.trim().isEmpty) {
      print("name invalid");
      return;
    }

    RegExp regExp = RegExp(_RegisterScreenState.pattern);
    if (_controllerEmail.text.trim().isEmpty || !regExp.hasMatch(_controllerEmail.text)) {
      print("email invalid");
      return;
    }
    if (_controllerPassword.text.trim().isEmpty) {
      print("password invalid");
      return;
    }

    _register(context,_controllerName.text.toString(), _controllerEmail.text.toString(),_controllerPassword.text.toString());
  }

  void _register(BuildContext context,String name,String email,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user.updateProfile(displayName: name,photoURL: '').then((value) {

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, login);
        });

      });

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
                width: getProportionateScreenWidth(120.0),
                height: getProportionateScreenWidth(120.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(72.0),
              ),
              Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(24.0)),
                        child: TextFormField(
                          controller: _controllerName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: nameHint,
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
                          controller: _controllerEmail,
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
                          controller: _controllerPassword,
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
                    onPressed: () => _validation(context),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimary),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      btnRegister,
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
                      text: alreadyHaveAnAccount,
                      style: TextStyle(color: kText2, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: loginText,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: kPrimary,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushReplacementNamed(context, login))
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

