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

class _ReservasiScreenState  extends State<ReservasiScreen> {

  User user;
  Stream<QuerySnapshot> _reservation;

  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }


  void getReservationData()  {
    _reservation = FirebaseFirestore.instance
        .collection("reservation")
        .where('user_id', isEqualTo: user.uid)
        .where('time', isGreaterThan : DateTime.now())
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
          AppLocalizations.of(context).navBarTextReservasi,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _reservation,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty){
                Reservation reservation = new Reservation();
                for (DocumentSnapshot snap in snapshot.data.docs) {
                  reservation = Reservation.fromJson(snap.data());
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
                    child: Container(
                      width: double.infinity,
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(context).nameHint,
                                style: TextStyle(fontSize: 14.0, color: kText2)),
                            SizedBox(height: getProportionateScreenWidth(8.0)),
                            Text(
                              user.displayName,
                              style: TextStyle(
                                  color: kText1,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(24.0),
                            ),
                            Text(AppLocalizations.of(context).emailHint,
                                style: TextStyle(fontSize: 14.0, color: kText2)),
                            SizedBox(height: getProportionateScreenWidth(8.0)),
                            Text(
                              user.email,
                              style: TextStyle(
                                  color: kText1,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(24.0),
                            ),
                            Text(AppLocalizations.of(context).time,
                                style: TextStyle(fontSize: 14.0, color: kText2)),
                            SizedBox(height: getProportionateScreenWidth(8.0)),
                            Text(
                              reservation.time.toString(),
                              style: TextStyle(
                                  color: kText1,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(24.0),
                            ),
                            Text(AppLocalizations.of(context).queueNumber,
                                style: TextStyle(fontSize: 14.0, color: kText2)),
                            SizedBox(height: getProportionateScreenWidth(56.0)),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                reservation.queueNumber.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kPrimary,
                                    fontSize: 56.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(56.0),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).note,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kText2, fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            } else if (snapshot.hasData && snapshot.data.docs.isEmpty){
              return EmptyReservasi();
            }

            return Center(
              child: CircularProgressIndicator(),
            );
         }
      ),
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
        SizedBox(
          height: getProportionateScreenWidth(112.0),
        ),
        Center(
            child: SvgPicture.asset(
              "assets/illustrations/emptyreservasi.svg",
              width: getProportionateScreenWidth(140),
            )),
        SizedBox(
          height: getProportionateScreenHeight(56.0),
        ),
        Center(
            child: Text(
              AppLocalizations.of(context).emptyReservasiTitle,
              style: TextStyle(
                  color: kText1, fontWeight: FontWeight.bold, fontSize: 18.0),
            )),
        SizedBox(
          height: getProportionateScreenHeight(24.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(36.0)),
          child: Center(
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: AppLocalizations.of(context).emptyReservasiSubtitle,
                    style: TextStyle(fontSize: 16.0, color: kText2),
                    children: [
                      TextSpan(
                          text: AppLocalizations.of(context).navBarTextHome,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: kPrimary,
                              fontWeight: FontWeight.bold))
                    ])),
          ),
        )
      ],
    );
  }
}
