import 'package:dentistReservationApp/models/Reservation.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReservasiScreen extends StatefulWidget {
  @override
  _ReservasiScreenState createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  User user;
  Stream<QuerySnapshot> _reservation;

  // fungsi untuk mendapatkan data user
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  // fungsi untuk mendapatkan data reservasi
  void getReservationData() {
    _reservation = FirebaseFirestore.instance
        .collection("reservation")
        .where('user_id', isEqualTo: user.uid)
        .where('time', isGreaterThan: DateTime.now())
        .orderBy('time', descending: false)
        .limit(1)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getReservationData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // menampilkan judul halaman reservasi
          AppLocalizations.of(context).navBarTextReservasi,
          style: TextStyle(
              // memberi style warna ukuran dan ketebalan text
              color: kPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _reservation,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              Reservation reservation = new Reservation();
              for (DocumentSnapshot snap in snapshot.data.docs) {
                reservation = Reservation.fromJson(snap.data());
              }
              return SingleChildScrollView(
                child: Padding(
                  // memberi jarak dikiri dan kanan elemen
                  padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                  child: Container(
                    width: double
                        .infinity, // panjang elemen mengikuti panjang device
                    decoration: BoxDecoration(
                        color: kWhite, // memberi warna pada elemen
                        // membuat lengkungan pada elemen
                        borderRadius: BorderRadius.circular(
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
                      padding:
                          EdgeInsets.all(getProportionateScreenWidth(24.0)),
                      // menampilkan elemen secara vertical
                      child: Column(
                        // menampilkan elemen dimulai dari kiri layar
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // tinggi elemen mengikuti jumlah conten
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // menampilkan nama
                          Text(AppLocalizations.of(context).nameHint,
                              // memberi style warna dan ukuran text
                              style: TextStyle(fontSize: 14.0, color: kText2)),
                          SizedBox(height: getProportionateScreenWidth(8.0)),
                          Text(
                            // menampilkan nama
                            user.displayName,
                            style: TextStyle(
                                color: kText1, // memberi warna
                                fontSize: 18.0, // memberi ukuran
                                fontWeight:
                                    FontWeight.bold), // memberi ketebalan
                          ),
                          // memberi jarak antar elemen menggunakan sizebox
                          SizedBox(
                            height: getProportionateScreenHeight(24.0),
                          ),
                          Text(
                              AppLocalizations.of(context)
                                  .emailHint, // menampilkan email
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color:
                                      kText2)), // memberi style ukuran dan warna text
                          // membuat jarak antar elemen menggunkanan sizebox
                          SizedBox(height: getProportionateScreenWidth(8.0)),
                          // menampilkan email
                          Text(
                            // menampilkan email
                            user.email,
                            style: TextStyle(
                                color: kText1, // memberi warna
                                fontSize: 18.0, // memberi ukuran
                                fontWeight:
                                    FontWeight.bold), // memberi ketebalan
                          ),
                          // membuat jarak antar elemen menggunkan sizebox
                          SizedBox(
                            height: getProportionateScreenHeight(24.0),
                          ),
                          Text(
                              AppLocalizations.of(context)
                                  .time, // menampilkan text waktu
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color:
                                      kText2)), // memberi style warna dan ukuran text
                          // membuat jarakl antar elemen menggunkan sizebox
                          SizedBox(height: getProportionateScreenWidth(8.0)),
                          Text(
                            // menampilkan waktu reservasi
                            reservation.time.toString(),
                            style: TextStyle(
                                color: kText1, // memberi warna text
                                fontSize: 18.0, // memberi ukuran text
                                fontWeight:
                                    FontWeight.bold), // memberi ketebalan text
                          ),
                          // membuat jarakl antar elemen menggunkan sizebox
                          SizedBox(
                            height: getProportionateScreenHeight(24.0),
                          ),
                          Text(
                              AppLocalizations.of(context)
                                  .queueNumber, // menampilkan nomor urutan
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color:
                                      kText2)), // memberi style warna dan ukuran text
                          // membuat jarakl antar elemen menggunkan sizebox
                          SizedBox(height: getProportionateScreenWidth(56.0)),
                          // menampilkan nomor urut
                          Align(
                            // posisi text ditengah
                            alignment: Alignment.center,
                            child: Text(
                              // menampilkan nomor antrian
                              reservation.queueNumber.toString(),
                              textAlign: TextAlign.center, // text center
                              style: TextStyle(
                                  color: kPrimary, // memberi warna text
                                  fontSize: 56.0, // memberi ukuran text
                                  fontWeight: FontWeight
                                      .bold), // memberi ketebalan text
                            ),
                          ),
                          // membuat jarakl antar elemen menggunkan sizebox
                          SizedBox(
                            height: getProportionateScreenHeight(56.0),
                          ),
                          // menampilkan catatan reservasi
                          Align(
                            // pisisi text ditengah
                            alignment: Alignment.center,
                            child: Text(
                              // menampilkan catatan atau note
                              AppLocalizations.of(context).note,
                              textAlign:
                                  TextAlign.center, // text berada ditengah
                              style: TextStyle(
                                  color: kText2,
                                  fontSize:
                                      12.0), // memberi style warna dan ukuran text
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasData && snapshot.data.docs.isEmpty) {
              // jika data kosong maka tampilkan halaman ini
              return EmptyReservasi();
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
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
        // membuat jarakl antar elemen menggunkan sizebox
        SizedBox(
          height: getProportionateScreenWidth(112.0),
        ),
        Center(
            // menampilkan ilustrasi
            child: SvgPicture.asset(
          "assets/illustrations/emptyreservasi.svg",
          width: getProportionateScreenWidth(140), // panjang elemen ilustrasi
        )),
        // membuat jarakl antar elemen menggunkan sizebox
        SizedBox(
          height: getProportionateScreenHeight(56.0),
        ),
        // menampilkan judul halaman kosong
        Center(
            child: Text(
          // menampilkan judul reservasi kosong
          AppLocalizations.of(context).emptyReservasiTitle,
          style: TextStyle(
              // memberi style warna ukuran da ketebalan text
              color: kText1,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        )),
        // membuat jarakl antar elemen menggunkan sizebox
        SizedBox(
          height: getProportionateScreenHeight(24.0),
        ),
        // menampilkan subjudul halaman kosong
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(36.0)),
          child: Center(
            child: RichText(
                // text berada ditengah
                textAlign: TextAlign.center,
                text: TextSpan(
                    // menampilkan subtitle text reservasi kosong
                    text: AppLocalizations.of(context).emptyReservasiSubtitle,
                    // memberi style warna dan ukuran text
                    style: TextStyle(fontSize: 16.0, color: kText2),
                    children: [
                      TextSpan(
                          // menampilkan text beranda
                          text: AppLocalizations.of(context).navBarTextHome,
                          style: TextStyle(
                              fontSize: 16.0, // memberi ukuran text
                              color: kPrimary, // memberi warna text
                              fontWeight:
                                  FontWeight.bold)) // memberi ketebalan text
                    ])),
          ),
        )
      ],
    );
  }
}
