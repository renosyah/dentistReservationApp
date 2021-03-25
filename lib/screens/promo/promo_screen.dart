import 'package:flutter/material.dart';
import 'package:reservasiui/utils/colors.dart';
import 'package:reservasiui/utils/size_config.dart';

class PromoScreen extends StatefulWidget {
  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar beserta judul
      appBar: AppBar(
        title: Text(
          // menampilkan judul halaman
          AppLocalizations.of(context).promoTextAppBar,
          style: TextStyle(
              // memberi style ukuran warna dan ketebelan pada judul
              color: kPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          // memberi jarak disisi kiri dan kanan eleme
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24.0)),
          // menampilkan elemen secara vertical
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // menempatkan elemen ditengah layar
            children: [
              // menggunakan list untuk menampilkan item promo
              ...List.generate(2, (index) => BuildPromoItem()),
              // memberi jarak menggunakan sizebox antar elemen
              SizedBox(
                height: getProportionateScreenWidth(24.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// item untuk build promo agar bisa di looping
class BuildPromoItem extends StatelessWidget {
  const BuildPromoItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // panjang elemen mengikuti panjang device
      margin: EdgeInsets.only(top: getProportionateScreenWidth(24.0)),
      decoration: BoxDecoration(
          color: kWhite, // memberi warna pada elemen
          borderRadius:
              // membuat lengkungan pada elemen
              BorderRadius.circular(getProportionateScreenWidth(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 8, // memberi blur pada shadow
                spreadRadius: 4, // memberi lebar blur pada shadow
                offset:
                    Offset(0.0, 0.0), // memberi arah x dan y blur pada shadow
                color: kText1.withOpacity(0.1)) // memberi warna shadow
          ]),
      child: Padding(
        // memberi jarak di semua sisi pada elemen
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        // menampilkan elemen secara horizontal
        child: Row(
          children: [
            // panjang menyesuaikan panjang devicec
            Expanded(
              // menampilkan elemen secara vertical
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // memulai elemen dari sisi kiri
                mainAxisSize:
                    MainAxisSize.min, // tinggi elemen mengikuti tinggi conten
                children: [
                  // menampilkan judul promo
                  Text(
                    // menampilkan judul promo
                    "Voucher Rp. 20.000",
                    maxLines: 2, // maksimal 2 baris
                    overflow: TextOverflow
                        .ellipsis, // lebi dari 2 baris ditampilkan dalam bentuk titik titik
                    style: TextStyle(
                        color: kText1, // memberi warna pada text
                        fontWeight:
                            FontWeight.bold, // memberi ketebalan pada text
                        fontSize: 18.0), // memberi ukuran pada text
                  ),
                  // membuat jarak antar elemen menggunakan sizebox
                  SizedBox(
                    height: getProportionateScreenHeight(4.0),
                  ),
                  // menampilkan subtitle dari promo
                  Text(
                    // menampilkan deskripsi promo
                    "Spesial Promo Hari Ulang Tahun Klinik D'Gigi",
                    // memberi style ukuran dan warna pada text
                    style: TextStyle(fontSize: 14.0, color: kText2),
                  )
                ],
              ),
            ),
            // membuat jarak antar elemen menggunakan sizebox
            SizedBox(
              width: getProportionateScreenWidth(16.0),
            ),
            // button untuk kalim promo
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: getProportionateScreenWidth(
                      96.0), // menentukan panjang button klaim
                  height: getProportionateScreenHeight(
                      44.0)), // menentukan tinggi button klaim
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        kPrimary), // memberi  warna button
                    elevation: MaterialStateProperty.all(
                        0)), // memberi shadow pada button
                child: Text(
                  // menampilkan text klaim
                  AppLocalizations.of(context).claim,
                  style: TextStyle(
                    color: kWhite, // memberi warna pada text
                    fontSize: 14.0, // memberi ukuran pada text
                    fontWeight: FontWeight.bold, // memberi ketebalan pada text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
