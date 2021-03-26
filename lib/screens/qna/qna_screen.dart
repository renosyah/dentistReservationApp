import 'package:dentistReservationApp/models/QuestionAndAnswer.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QnaScreen extends StatefulWidget {
  static final data = true;
  final ValueChanged<int> onTap;

  QnaScreen({this.onTap});

  @override
  _QnaScreenState createState() => _QnaScreenState(onTap: this.onTap);
}

class _QnaScreenState extends State<QnaScreen> {
  ValueChanged<int> onTap;
  Stream<QuerySnapshot> _qna;

  // konstruktor
  _QnaScreenState({this.onTap});


  // fungsi untuk mendapatkan data qna
  void getQnAData() {
    _qna = FirebaseFirestore.instance
        .collection("qna")
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    getQnAData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // menampilkan judul halaman tanya jawab
          AppLocalizations.of(context).navBarTextQna,
          style: TextStyle(
              // memberi style warna ukuran dan ketebelan judul halaman
              color: kPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _qna,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              List<QuestionAndAnswer> item = [];
              for (DocumentSnapshot snap in snapshot.data.docs) {
                item.add(QuestionAndAnswer.fromJson(snap.data()));
              }
              return SingleChildScrollView(
                child: Padding(
                  // memberi jarak dikiri dan kanan elemen
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
                  child: Column(
                    children: [
                      // menampilkan item list untuk tanya jawab
                      ...item.map((e) => BuildQnaItem(questionAndAnswer: e)),
                      SizedBox(
                        height: getProportionateScreenWidth(24.0),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData && snapshot.data.docs.isEmpty) {
              // jika datanya kosong
              return EmptyQna();
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class BuildQnaItem extends StatelessWidget {
  QuestionAndAnswer questionAndAnswer;
  BuildQnaItem({this.questionAndAnswer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // menampilkan detail dari tanya jawab menggunakan dialog
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              // memri jarak disemua sisi elemen
              padding: EdgeInsets.all(getProportionateScreenWidth(36.0)),
              child: Container(
                width:
                    double.infinity, // panjang elemen mengikuti panjang device
                decoration: BoxDecoration(
                    color: kWhite, // memberi warna text
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
                  // memri jarak disemua sisi elemen
                  padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                  child: SingleChildScrollView(
                    child: Column(
                      // menampilkan elemen secara vertical atau kebawah
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // menampilkan text tanya jawab
                        Text(AppLocalizations.of(context).ask,
                            style: TextStyle(
                                fontSize: 14.0, // memberi ukuran text
                                color: kText2, // memberi warna text
                                decoration: TextDecoration
                                    .none)), // memberi style none atau tidak ada
                        // membuat jarak antar elemen emnggunakan sizebox
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        // menampilkan pertanyaan
                        Text(
                          // menampilkan pertanyaan
                          questionAndAnswer.question,
                          style: TextStyle(
                              color: kText1, // memberi warna text
                              fontSize: 18.0, // memberi  ukuran text
                              decoration: TextDecoration
                                  .none, // memberi dekorasi text tidak ada
                              fontFamily: 'Roboto', // memberi jenis font
                              fontWeight:
                                  FontWeight.bold), // memberi ketebalan text
                        ),
                        // membuat jarak antar elemen menggunakan sizebox
                        SizedBox(
                          height: getProportionateScreenHeight(24.0),
                        ),
                        // menampilkan jawaban
                        Text(AppLocalizations.of(context).textAnswer,
                            style: TextStyle(
                                fontSize: 14.0, // memberi ukuran text
                                color: kText2, // memberi warna text
                                decoration: TextDecoration
                                    .none)), // memberi dekorasi text tidak ada
                        // membuat jarak antar elemen menggunakan sizebox
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          // menampilkan jawaban
                          questionAndAnswer.answer,
                          style: TextStyle(
                              color: kText1, // memberi warna text
                              fontFamily: 'Roboto', // memberi jenis font
                              decoration: TextDecoration
                                  .none, // memberi dekorasi text tidak ada
                              fontSize: 18.0, // memberi ukuran text
                              fontWeight:
                                  FontWeight.bold), // memberi ketebalan text
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      // item tanya jawab
      child: Container(
        width: double.infinity, // panjang elemen mengikuti panjang device
        margin: EdgeInsets.only(top: getProportionateScreenWidth(24.0)),
        decoration: BoxDecoration(
            color: kWhite, // memberi warna elemen
            // membuat lengkungan pada elemen
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(24.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 8,// memberi blur pada shadow
                  spreadRadius: 4,// memberi lebar blur pada shadow
                  offset: Offset(0.0, 0.0),// memberi arah x dan y blur pada shadow
                  color: kText1.withOpacity(0.1))// memberi warna shadow
            ]),
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // menampilkan pertanyaan
              Text(
                questionAndAnswer.question,
                // pertanyaan maksimal 2 baris
                maxLines: 2,
                // jika lebih dari 2 baris makan ditampilkan titik titik
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    // memberi style warna ukuran dan ketebalan pada text
                    color: kText1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              // membuat jarak antar elemen menggunakan sizebox
              SizedBox(
                height: getProportionateScreenHeight(4.0),
              ),
              // menampilkan jawaban
              RichText(
                  maxLines: 1,
                  // jika lebih dari 2 baris makan ditampilkan titik titik
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      // menampilkan text jawaban
                      text: "${AppLocalizations.of(context).answer}",
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: 14.0), // memberi warna dan ukruan pada text
                      children: [
                        TextSpan(
                            text:
                                // menampilkan jawaban jika kosong yakni menunggu
                                "${questionAndAnswer.answer.isEmpty ? AppLocalizations.of(context).pending : questionAndAnswer.answer}",
                            style: TextStyle(
                                color: kPending,
                                fontSize:
                                    14.0)) // memberi warna dan ukuran pada text
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

// halaman ini akan ditampilkan jika data tanya jawab masih kosong
class EmptyQna extends StatelessWidget {
  const EmptyQna({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // menampilkan elemen secara vertical
    return Column(
      children: [
        // membuat jarak antar elemen menggunakan sizebox
        SizedBox(
          height: getProportionateScreenWidth(112.0),
        ),
        // menmpatkan ilustrasi ditengah
        Center(
            // menampilkan ilustrasi
            child: SvgPicture.asset(
          "assets/illustrations/emptyqna.svg",
          width: getProportionateScreenWidth(140),
        )),
        // membuat jarak antar elemen menggunakan sizebox
        SizedBox(
          height: getProportionateScreenHeight(56.0),
        ),
        // menampatkan judul ditengah
        Center(
            child: Text(
          // menampilkan judul halaman kosong
          AppLocalizations.of(context).emptyQnaTitle,
          style: TextStyle(
              // memberi style warna ketebalan dan ukuran text
              color: kText1,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        )),
        // membuat jarak antar elemen menggunakan sizebox
        SizedBox(
          height: getProportionateScreenHeight(24.0),
        ),
        // menampilkan subjudul halaman kosong
        Padding(
          // membuat jarak disisi kiri dan kanan elemen
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(36.0)),
          child: Center(
            child: RichText(
                // menempatkan subtitle ditengah
                textAlign: TextAlign.center,
                text: TextSpan(
                    // menampilkan subtitle
                    text: AppLocalizations.of(context).emptyQnaSubtitle,
                    // memberi style warna dan ukuran pada text
                    style: TextStyle(fontSize: 16.0, color: kText2),
                    children: [
                      TextSpan(
                          // menampilkan text beranda
                          text: AppLocalizations.of(context).navBarTextHome,
                          style: TextStyle(
                              fontSize: 16.0, // memberi ukuran text
                              color: kPrimary, // memberi  warna text
                              fontWeight:
                                  FontWeight.bold)) // memberi ketebalan text
                    ])),
          ),
        )
      ],
    );
  }
}
