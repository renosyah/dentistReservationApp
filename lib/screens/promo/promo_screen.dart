import 'package:dentistReservationApp/models/Promo.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PromoScreen extends StatefulWidget {
  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  User user;
  Stream<QuerySnapshot> _promo;

  // fungsi untuk mendapatkan data user
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  // fungsi untuk mendapatkan
  // data promo
  void getPromoData() {
    _promo = FirebaseFirestore.instance
        .collection("promo")
        .snapshots();
  }

  void claimPromoData(String id) async {
    var query = await FirebaseFirestore.instance
        .collection("promo")
        .doc(id)
        .get();

    Promo promo = Promo.fromJson(query.data());

    promo.claimBy.add(user.uid);
    await FirebaseFirestore.instance
        .collection("promo")
        .doc(id)
        .set(promo.toJson()
    );

    _showDialogSuccessClaim(promo);
  }

  // fungsi untuk menampilkan dialog
  // data promo berhasil di claim
  Future<void> _showDialogSuccessClaim(Promo p) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).alert),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("${p.name} ${AppLocalizations.of(context).promoAdded}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getPromoData();
  }

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
      body: StreamBuilder<QuerySnapshot>(
          stream: _promo,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              List<Promo> list = new List<Promo>();
              for (DocumentSnapshot snap in snapshot.data.docs) {
                Promo p = Promo.fromJson(snap.data());
                p.id = snap.id;
                list.add(p);
              }
              // menggunakan list untuk menampilkan item promo
              return 	SingleChildScrollView(
                child: Padding(
                  // memberi jarak disisi kiri dan kanan eleme
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
                  // menampilkan elemen secara vertical
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center, // menempatkan elemen ditengah layar
                    children: [
                      ...list.map((e) => BuildPromoItem(uid : user.uid, promo: e, claim: () { claimPromoData(e.id); },)),
                      // memberi jarak menggunakan sizebox antar elemen
                      SizedBox(
                        height: getProportionateScreenWidth(24.0),
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          })
    );
  }
}

// item untuk build promo agar bisa di looping
class BuildPromoItem extends StatelessWidget {

  String uid;
  Promo promo;
  Function claim;
  BuildPromoItem({this.uid, this.promo,this.claim});

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
                    this.promo.name,
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
                    this.promo.description,
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
              child: promo.claimBy.contains(uid) || (promo.claimBy.length >= 3) ? ElevatedButton(
                onPressed: (){ },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        kIndicator), // memberi  warna button
                    elevation: MaterialStateProperty.all(
                        0)), // memberi shadow pada button
                child: Text(
                  // menampilkan text klaim
                  AppLocalizations.of(context).claim,
                  style: TextStyle(
                    color: kTextHint, // memberi warna pada text
                    fontSize: 14.0, // memberi ukuran pada text
                    fontWeight: FontWeight.bold, // memberi ketebalan pada text
                  ),
                ),
              ) : ElevatedButton(
                onPressed: claim,
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
