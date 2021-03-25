import 'package:flutter/material.dart';
import 'package:reservasiui/utils/colors.dart';
import 'package:reservasiui/utils/size_config.dart';
import 'package:reservasiui/utils/strings.dart';

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
          AppLocalizations.of(context).promoTextAppBar,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // menggunakan list untuk menampilkan item promo
              ...List.generate(2, (index) => BuildPromoItem()),
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
      width: double.infinity,
      margin: EdgeInsets.only(top: getProportionateScreenWidth(24.0)),
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(0.0, 0.0),
                color: kText1.withOpacity(0.1))
          ]),
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // menampilkan judul promo
                  Text(
                    "Voucher Rp. 20.000",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: kText1,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(4.0),
                  ),
                  // menampilkan subtitle dari promo
                  Text(
                    "Spesial Promo Hari Ulang Tahun Klinik D'Gigi",
                    style: TextStyle(fontSize: 14.0, color: kText2),
                  )
                ],
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(16.0),
            ),
            // button untuk kalim promo
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: getProportionateScreenWidth(96.0),
                  height: getProportionateScreenHeight(44.0)),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimary),
                    elevation: MaterialStateProperty.all(0)),
                child: Text(
                  AppLocalizations.of(context).claim,
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
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
