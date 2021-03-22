import 'package:dentistReservationApp/models/data_tips_and_tricks.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:flutter/material.dart';

class DetailTipsScreen extends StatelessWidget {
  final String title;
  final String image;
  final List<DetailTipsAndTrick> detailTipAndTrickList;

  const DetailTipsScreen(
      {Key key, this.title, this.image, this.detailTipAndTrickList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tipsTitle,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(24.0)),
                child: Image.asset(
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
                color: kIndicator,
                thickness: 0.5,
                height: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$developer $nim \nby Kementrian Kesehatan Republik Indonesia",
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
