import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  // inisialisasi controller nama
  TextEditingController _controllerName = TextEditingController();
  // inisialisasi controller  email
  TextEditingController _controllerEmail = TextEditingController();
  // inisialisasi controller password
  TextEditingController _controllerPassword = TextEditingController();

  // fungsi validasi
  void _validation(BuildContext context) {
    if (_controllerName.text.trim().isEmpty) {
      print("name invalid");
      return;
    }

    RegExp regExp = RegExp(_RegisterScreenState.pattern);
    if (_controllerEmail.text.trim().isEmpty ||
        !regExp.hasMatch(_controllerEmail.text)) {
      print("email invalid");
      return;
    }
    if (_controllerPassword.text.trim().isEmpty) {
      print("password invalid");
      return;
    }

    _register(context, _controllerName.text.toString(),
        _controllerEmail.text.toString(), _controllerPassword.text.toString());
  }

  // fungsi register user baru
  void _register(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user
          .updateProfile(displayName: name, photoURL: '')
          .then((value) {
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
      // menggunakan singlechildscrollview agar screen bisa digulirkan atau discrolling
      body: SingleChildScrollView(
        child: Padding(
          // memberi jarak hanya dibagian bawah elemen
          padding: EdgeInsets.only(bottom: getProportionateScreenHeight(36.0)),
          // menampilkan lemen secara vertical
          child: Column(
            children: [
              // membuat jarak antar elemen menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(136.0),
              ),
              Image.asset(
                // menampilkan gambar atau logo
                "assets/logo/logo.png",
                // panjang logo
                width: getProportionateScreenWidth(120.0),
                // tinggi logo
                height: getProportionateScreenWidth(120.0),
              ),
              // membuat jarak antar elemen menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(72.0),
              ),
              Form(
                  // menampilkan elemen secara vertical
                  child: Column(
                children: [
                  Padding(
                    // memberi jarak dikiri dan kanan elemen
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      // textfield untuk memasukan nama
                      controller: _controllerName, // controller untuk nama
                      keyboardType: TextInputType.name, // inputytpe yakni nama
                      decoration: InputDecoration(
                        // ,menampilkan hint untuk nama
                        hintText: AppLocalizations.of(context).nameHint,
                        filled: true, // mengaktifkan warna pada textformdield
                        fillColor:
                            kBackgroundTextField, // memberi warna pada textformdield
                        contentPadding: EdgeInsets.symmetric(
                            // memberi jarak dikiri dan kanan didalam textformfield
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            // memberi border atau bingkai
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            // membuat lengkungan pada textformdield
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  ),
                  // memberi jarak antar elemen menggunakan sizebox
                  SizedBox(
                    height: getProportionateScreenHeight(36.0),
                  ),
                  Padding(
                    // memberi jarak dikiri dan kanan pada textformdield
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      // textfield untuk memasukan email
                      controller: _controllerEmail, // controller untuk email
                      keyboardType:
                          TextInputType.emailAddress, // input type yakni email
                      decoration: InputDecoration(
                        // menampilkan hinti untuk email
                        hintText: AppLocalizations.of(context).emailHint,
                        filled: true, // mengaktifkan warna pada textformdield
                        fillColor:
                            kBackgroundTextField, // memberi warna pada textformdield
                        contentPadding: EdgeInsets.symmetric(
                            // memberi jarak dikiri dan kanan didalam textformdield
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            // memberi border atau bingkai
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            // membuat lengkungan pada textformdield
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  ),
                  // membuat jarak antar elemen menggunakan sizebox
                  SizedBox(
                    height: getProportionateScreenHeight(36.0),
                  ),
                  Padding(
                    // memberi jarak dikiri dan kanan pada textformdield
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      // textfield untuk memasukan password
                      controller:
                          _controllerPassword, // controller untuk password
                      obscureText: true, // membuat text menjadi titik titik
                      decoration: InputDecoration(
                        // manampilkan hint untuk password
                        hintText: AppLocalizations.of(context).passwordHint,
                        filled: true, // mangaktifkan warna pada textformdield
                        fillColor:
                            kBackgroundTextField, // memberi warna pada textformdield
                        contentPadding: EdgeInsets.symmetric(
                            // memberi jarak dikiri dan kanan didalam textformdield
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            // memberi border atau bingkai
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            // membuat lengkungan pada textformdield
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  )
                ],
              )),
              // membuat jarak antar elemen menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(120.0),
              ),
              // tombol register atau daftar
              Padding(
                // membuat jarak dikiri dan kanan button
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double
                          .infinity, // panjang button mengikuti panjang device
                      height: getProportionateScreenHeight(
                          72.0)), // menentukan tinggi button
                  child: ElevatedButton(
                    onPressed: () => _validation(
                        context), // ketika diklik akan menjalan fungsi _validation
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            kPrimary), // memberi warna pada button
                        elevation: MaterialStateProperty.all(
                            0)), // memberi shadow pada button
                    child: Text(
                      // menampilkan text Daftar
                      AppLocalizations.of(context).btnRegister,
                      style: TextStyle(
                        color: kWhite, // memberi warna text
                        fontSize: 22.0, // memberi ukuran text
                        fontWeight: FontWeight.bold, // memberi ketebalan text
                      ),
                    ),
                  ),
                ),
              ),
              // membuat jarak antar elemen menggunkan sizebox
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              // text sekaligus navigasi jika akun pernah dibuat
              RichText(
                  text: TextSpan(
                      // menampilkan text sudah punya akun ?
                      text: AppLocalizations.of(context).alreadyHaveAnAccount,
                      // memberi style warna dan ukuran text
                      style: TextStyle(color: kText2, fontSize: 16.0),
                      children: [
                    TextSpan(
                        // menampilkan text silahkan masuk!
                        text: AppLocalizations.of(context).loginText,
                        style: TextStyle(
                            fontSize: 16.0, // memberi ukuran text
                            color: kPrimary, // memberi warna text
                            fontWeight:
                                FontWeight.bold), // memberi ketebalan text
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacementNamed(
                              context,
                              login)) // ketika diklik akan mengarah ke halaman login
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
