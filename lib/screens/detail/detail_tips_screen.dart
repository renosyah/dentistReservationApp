import 'package:dentistReservationApp/models/data_tips_and_tricks.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DetailTipsScreen extends StatelessWidget {
  final String title; // variable untuk mengambil title dari screen sebelumnya
  final String image; // variable untuk mengambil image dari screen sebelumnya
  final List<DetailTipsAndTrick>
      detailTipAndTrickList; // variable untuk mengambil list detail tips dan trik dari screen sebelumnya

  // konstruktor dari class DetailTipsScreen
  const DetailTipsScreen(
      {Key key, this.title, this.image, this.detailTipAndTrickList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar beserta judul
      appBar: AppBar(
        // menampilkan text appbar
        title: Text(
          AppLocalizations.of(context).tipsTitle,
          // meberikan style pada text yakni ukuran, ketebalan dan warna pada text
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // menggunakan column untuk menampilkan data list secara vertical
        child: Column(
          // membuat element berada disisi kiri parent
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              // membuat gambar memiliki lengkungan di empat sisi
              child: ClipRRect(
                borderRadius:
                    // mebuat lengkungan pada penampung gambar dengan ukuran 24 pixel dari panjang layar
                    BorderRadius.circular(getProportionateScreenWidth(24.0)),
                child: Image.asset(
                  // gambar
                  image,
                  width:
                      double.infinity, // ukuran panjang mengikuti panjang layar
                  height: getProportionateScreenWidth(
                      200.0), // ukuran layar diambil dari tinggi device yakni 200 pixel
                  fit: BoxFit
                      .cover, // menampilkan gambar pada container secara penuh
                ),
              ),
            ),
            Padding(
              // memberi jarak di kiri dan kanan layar sebesar 24 pixel
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24.0)),
              child: Text(
                title, // menampilkan text atau judul
                style: TextStyle(
                    // memberi style ukuran, warna serta ketebalan pada text
                    color: kText1,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // mebuat jarak antar element menggunakan sizebox
            SizedBox(
              height: getProportionateScreenWidth(24.0),
            ),
            // list untuk detail tips dan trik
            ...List.generate(
                detailTipAndTrickList.length,
                (index) => Column(
                      // memulai elemet dari sisi kiri
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          // memberi jarak sebesar 24 pixel disisi kiri dan kanan element
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(24.0)),
                          child: Text(
                            // menampilkan text
                            detailTipAndTrickList[index].subtitle,
                            style: TextStyle(
                                color: kText1, // memberi warna pada text
                                fontSize: 18.0, // memberi ukuran pada text
                                fontWeight: FontWeight
                                    .bold), // memberi ketebalan pada text
                          ),
                        ),
                        // membuat jarak menggunakan sizebox
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Padding(
                          // memberi jarak disisi kiri dan kanan elemen
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(24.0)),
                          child: Text(
                            // menampilkan text
                            detailTipAndTrickList[index].description,
                            // meberi style warna dan ukran pada text
                            style: TextStyle(color: kText2, fontSize: 16.0),
                          ),
                        ),
                        // membuat jarak menggunakan sizebox antar elemen
                        SizedBox(
                          height: getProportionateScreenWidth(24.0),
                        )
                      ],
                    )),
            Padding(
              // memberi jarak disisi kiri dan kanan elemen
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24.0)),
              child: Divider(
                // garis pembatas
                color: kIndicator, // memberi warna garis
                thickness: 0.5, // membuat ketebalan garis
                height: 1, // membuat ketebalan garis
              ),
            ),
            // pemilik aplikasi beserta informasi kepemilikan tips dan trik diatas
            Padding(
              // meberi jarak di segala sisi elemen
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              child: Align(
                // membuat elemen berada ditengah
                alignment: Alignment.center,
                child: Text(
                  // menampilkan text pemilik aplikasi dan sumber informasi kesehatan gigi
                  "${AppLocalizations.of(context).developer} ${AppLocalizations.of(context).nim} \nby Kementrian Kesehatan Republik Indonesia",
                  textAlign: TextAlign.center, // menempatkan text ditengah
                  style: TextStyle(
                    color: kText2, // memberi warna pada text
                    fontSize: 14.0, // memberi ukuran pada text
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
