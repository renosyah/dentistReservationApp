import 'package:dentistReservationApp/routing/constanta.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
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
        // appbar berserta judul
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).navBarTextProfile,
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
              // menampilkan logo atau gambar ditengah screen
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
              // menampilkan nama
              Text(
                "${user.displayName}",
                style: TextStyle(
                    color: kText1, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              // menampilkan email
              Text(
                "${user.email}",
                style: TextStyle(color: kText2, fontSize: 18.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              // menu ke halaman tentang aplikasi
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
                          AppLocalizations.of(context).aboutApp,
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          AppLocalizations.of(context).aboutAppDesc,
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
              // menu ke halaman bantuan atau cara menggunakan aplikasi
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
                          AppLocalizations.of(context).helpApp,
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          AppLocalizations.of(context).helpAppDesc,
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
              // button logout
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double.infinity,
                      height: getProportionateScreenHeight(72.0)),
                  child: ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, login);
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimary),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text(
                      AppLocalizations.of(context).btnLogout,
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
