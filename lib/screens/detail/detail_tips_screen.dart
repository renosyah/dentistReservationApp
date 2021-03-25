import 'package:dentistReservationApp/models/data_tips_and_tricks.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DetailTipsScreen extends StatelessWidget {
  final String title;
  final String image;
  final List<DetailTipsAndTrick> detailTipAndTrickList;

  // konstruktor dari class DetailTipsScreen
  const DetailTipsScreen(
      {Key key, this.title, this.image, this.detailTipAndTrickList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar beserta judul
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).tipsTitle,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // menggunakan column untuk menampilkan data list secara vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              // membuat gambar memiliki lengkungan di empat sisi
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(24.0)),
                child: Image.asset(
                  // gambar
                  image,
                  width: double.infinity,
                  height: getProportionateScreenWidth(200.0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24.0)),
              child: Text(
                title,
                style: TextStyle(
                    color: kText1, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(24.0),
            ),
            // list untuk detail tips dan trik
            ...List.generate(
                detailTipAndTrickList.length,
                (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(24.0)),
                          child: Text(
                            detailTipAndTrickList[index].subtitle,
                            style: TextStyle(
                                color: kText1,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(8.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(24.0)),
                          child: Text(
                            detailTipAndTrickList[index].description,
                            style: TextStyle(color: kText2, fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenWidth(24.0),
                        )
                      ],
                    )),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24.0)),
              child: Divider(
                // garis pembatas
                color: kIndicator,
                thickness: 0.5,
                height: 1,
              ),
            ),
            // pemilik aplikasi beserta informasi kepemilikan tips dan trik diatas
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${AppLocalizations.of(context).developer} ${AppLocalizations.of(context).nim} \nby Kementrian Kesehatan Republik Indonesia",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kText2,
                    fontSize: 14.0,
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
