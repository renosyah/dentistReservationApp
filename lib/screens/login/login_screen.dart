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

  TextEditingController _controllerEmail =
      TextEditingController(); // membuat controller untuk email
  TextEditingController _controllerPassword =
      TextEditingController(); // membuat controller untuk password

  void _validation(BuildContext context) {
    RegExp regExp = RegExp(_LoginScreenState.pattern);
    if (_controllerEmail.text.trim().isEmpty ||
        !regExp.hasMatch(_controllerEmail.text)) {
      print("email invalid");
      return;
    }
    if (_controllerPassword.text.trim().isEmpty) {
      print("password invalid");
      return;
    }

    _login(context, _controllerEmail.text.toString(),
        _controllerPassword.text.toString());
  }

  void _login(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
    // inisialisasi ukuran smartphone
    SizeConfig().init(context);
    return Scaffold(
      // membuat halaman bisa di gulirkan atau scroll
      body: SingleChildScrollView(
        child: Padding(
          // memberi jarak hanya pada bagian bawah elemen
          padding: EdgeInsets.only(bottom: getProportionateScreenHeight(36.0)),
          child: Column(
            // menampilkan elemet secara vertical
            children: [
              // membuat jarak menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(136.0),
              ),
              // menampilkan gambar atau logo
              Image.asset(
                "assets/logo/logo.png",
                width: getProportionateScreenWidth(
                    160.0), // memberi ukuran panjang gambar
                height: getProportionateScreenWidth(
                    160.0), // memberi ukuran lebar gambar
              ),
              // membuat jarak menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(96.0),
              ),
              Form(
                  child: Column(
                // menmapilkan elemen secara vertical
                children: [
                  Padding(
                    // membuat jarak disisi kiri dan kanan elemen
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      // menampilkan field untuk memasukan email
                      controller: _controllerEmail, // controller untuk email
                      keyboardType: TextInputType
                          .emailAddress, // menentukan type text yakni email pada saat memasukan email
                      // memberi style atau dekorasi pada textformfield
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .emailHint, // hint pada textformfield
                        filled: true, // mengaktifkan warna textformfield
                        fillColor:
                            kBackgroundTextField, // memberi warna textformfield
                        contentPadding: EdgeInsets.symmetric(
                            // meberi jarak disisi kiri dan kenan didalam textformfield
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            // membuat garis disekeliling textformfield
                            borderSide:
                                // memberi ketebalan dan style pada border
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            // membuat lengkungan disemua sisi textformfield
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  ),
                  // membuat jarak menggunakan sizebox
                  SizedBox(
                    height: getProportionateScreenHeight(36.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        // memberi jarak disisi kiri dan kanan elemen
                        horizontal: getProportionateScreenWidth(24.0)),
                    child: TextFormField(
                      // menampilkan field untuk memasukan password
                      controller:
                          _controllerPassword, // controller untuk password
                      obscureText: true, // membuat text menjadi titik titik
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .passwordHint, // hint untuk password
                        filled: true, // mengaktifkan warna textformfield
                        fillColor:
                            kBackgroundTextField, // memberi warna textformfield
                        contentPadding: EdgeInsets.symmetric(
                            // memberi jarak disisi kiri dan kanan elemen didalam textformfield
                            horizontal: getProportionateScreenWidth(24.0),
                            vertical: getProportionateScreenWidth(16.0)),
                        border: OutlineInputBorder(
                            // membuat garis disekeliling textformfield
                            borderSide:
                                // memberi ketebalan dan style pada border
                                BorderSide(width: 0.0, style: BorderStyle.none),
                            // membuat lengkungan disemua sisi textformfield
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8.0))),
                      ),
                    ),
                  )
                ],
              )),
              // membuat jarang menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(120.0),
              ),
              // button login
              Padding(
                padding: EdgeInsets.symmetric(
                    // memberi jarak disisi kiri dan kanan elemen
                    horizontal: getProportionateScreenWidth(24.0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double
                          .infinity, // panjang button mengikuti panjang parent
                      height:
                          getProportionateScreenHeight(72.0)), // tinggi button
                  child: ElevatedButton(
                    onPressed: () {
                      // ketika button diklik akan menjalan fungsi _validation
                      this._validation(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            kPrimary), // memberi warna button
                        elevation: MaterialStateProperty.all(
                            0)), // memberi shadow atau bayangan pada button
                    child: Text(
                      // menampilkan text button
                      AppLocalizations.of(context).btnLogin,
                      style: TextStyle(
                        color: kWhite, // memberi warna pada text
                        fontSize: 22.0, // memberi ukuran pada text
                        fontWeight:
                            FontWeight.bold, // memberi ketebalan pada text
                      ),
                    ),
                  ),
                ),
              ),
              // memberi jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              // text sekaligus navigasi ke halaman register atau daftar
              RichText(
                  text: TextSpan(
                      // menampilkan text belum punya akun
                      text: AppLocalizations.of(context).dontHaveAnAccountYet,
                      // memberi style warna ukuran pada text
                      style: TextStyle(color: kText2, fontSize: 16.0),
                      children: [
                    TextSpan(
// menampilkan text yuk daftar
                        text: AppLocalizations.of(context).registerText,
                        style: TextStyle(
                            fontSize: 16.0, // memberi ukuran text
                            color: kPrimary, // memberi warna text
                            fontWeight:
                                FontWeight.bold), // memberi ketebalan text
                        recognizer:
                            TapGestureRecognizer() // membuat text dapat diklik dan menuju ke halaman register
                              ..onTap = () => Navigator.pushReplacementNamed(
                                  context, register))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
