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

  // fungsi untuk mendapatkan data user
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
            // menampilkan judul halaman
            AppLocalizations.of(context).navBarTextProfile,
            style: TextStyle(
                // memberi warna ketebelan dan ukuran pada text
                color: kPrimary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        // membuat halaman dapat digulirkan atau scrolling
        body: SingleChildScrollView(
          // menampilkan elemen secara vertical
          child: Column(
            //membuat elemen berada ditengah
            mainAxisAlignment: MainAxisAlignment.center,
            // membari ukran maksimal pada elemen column
            mainAxisSize: MainAxisSize.max,
            children: [
              // membuat jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(24.0),
              ),
              // menampilkan logo atau gambar ditengah screen
              Align(
                alignment: Alignment.center,
                // menampilkan logo
                child: Image.asset(
                  "assets/logo/logo.png",
                  width: getProportionateScreenWidth(
                      120.0), // memberi ukuran panjang gambar
                  height: getProportionateScreenWidth(
                      120.0), // memberi ukuran lebar gambar
                ),
              ),
              // membuat jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              // menampilkan nama
              Text(
                "${user.displayName}",
                // memberi style ukuran warna dan ketebalan pada text
                style: TextStyle(
                    color: kText1, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              // membuat jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              // menampilkan email
              Text(
                "${user.email}",
                // memberi style ukuran dan warna pada text
                style: TextStyle(color: kText2, fontSize: 18.0),
              ),
              // membuat jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(36.0),
              ),
              // menu ke halaman tentang aplikasi
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, about), // navigasi ke halaman about
                child: Container(
                  width: double
                      .infinity, // membuat panjang element mengikuti panjang device
                  margin: EdgeInsets.symmetric(
                      // memberi jarak disisi kiri dan kanan elemen
                      horizontal: getProportionateScreenWidth(24.0)),
                  decoration: BoxDecoration(
                      color: kWhite, // memberi warna text
                      borderRadius: BorderRadius.circular(
                          // membuat lengkungan elemen
                          getProportionateScreenWidth(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 8, // ukuran blur pada shadow
                            spreadRadius: 4, // lebar blur pada shadow
                            offset: Offset(0.0,
                                0.0), // arah sumbu x dan y blur pada shadow
                            color: kText1.withOpacity(0.1)) // warna shadow
                      ]),
                  child: Padding(
                    // memberi jarak disemua sisi pada elemen
                    padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                    // menampilkan elemen secara vertical
                    child: Column(
                      // menampilkan elemen dimulai dari kiri layar
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // menampilkan text tentang aplikasi
                          AppLocalizations.of(context).aboutApp,
                          style: TextStyle(
                              color: kText1, // memberi warna text
                              fontSize: 18.0, // memberi ukuran text
                              fontWeight: FontWeight
                                  .bold), // memberi ketebalan pada text
                        ),
                        // membuat jarak menggunakan sizebox
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          // menampilkan text deskripsi tentang aplikasi
                          AppLocalizations.of(context).aboutAppDesc,
                          // memberi warna dan ukuran text
                          style: TextStyle(color: kText2, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // memberi jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenHeight(24.0),
              ),
              // menu ke halaman bantuan atau cara menggunakan aplikasi
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, help), // navigasi ke halaman bantuan
                child: Container(
                  width: double
                      .infinity, // membuat panjang elemen mengikuti panjang device
                  margin: EdgeInsets.symmetric(
                      // memberi jarak disisi kiri dan kanan elemen
                      horizontal: getProportionateScreenWidth(24.0)),
                  decoration: BoxDecoration(
                      color: kWhite, // memberi warna pada elemen
                      borderRadius: BorderRadius.circular(
                          // membuat lengkungan pada elemen
                          getProportionateScreenWidth(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 8, // memberi blur pada shadow
                            spreadRadius: 4, // memberi lebar blur pada shadow
                            offset: Offset(0.0,
                                0.0), // memberi arah x dan y blur pada shadow
                            color:
                                kText1.withOpacity(0.1)) // memberi warna shadow
                      ]),
                  child: Padding(
                    // memberi jarak disemua sisi pada elemen
                    padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                    // menampilkan elemen secara vertical
                    child: Column(
                      // membuat elemen ditampilkan dimulai dari sisi kiri layar
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // menampilkan text bantuan
                          AppLocalizations.of(context).helpApp,
                          style: TextStyle(
                              color: kText1, // memberi warna text
                              fontSize: 18.0, // memberi ukuran text
                              fontWeight:
                                  FontWeight.bold), // memberi ketebalan text
                        ),
                        // membuat jarak menggunakan sizebox antar elemen
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Text(
                          // menampilkan text deskripsi  bantuan
                          AppLocalizations.of(context).helpAppDesc,
                          // memberi style warna dan ukuran text
                          style: TextStyle(color: kText2, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // membuat jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenWidth(56.0),
              ),
              // button logout
              Padding(
                // memberi jarak disisi kiri dan kanan elemen
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double
                          .infinity, // panjang button mengikuti panjang device
                      height: getProportionateScreenHeight(72.0)),
                  child: ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await FirebaseAuth.instance.signOut();
                        // setelah menekan tombol logout makan akan diarahkan ke halaman login
                        Navigator.pushReplacementNamed(context, login);
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            kPrimary), // memberi warna button
                        elevation: MaterialStateProperty.all(
                            0)), // memberi shadow pada button
                    child: Text(
                      // menampilkan text logout
                      AppLocalizations.of(context).btnLogout,
                      style: TextStyle(
                        color: kWhite, // memberi text
                        fontSize: 22.0, // memberi ukuran text
                        fontWeight: FontWeight.bold, // memberi ketebalan text
                      ),
                    ),
                  ),
                ),
              ),
              // memberi jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenWidth(24.0),
              ),
            ],
          ),
        ));
  }
}
