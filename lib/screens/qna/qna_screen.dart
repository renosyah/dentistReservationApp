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

  _QnaScreenState({this.onTap});


  @override
  void initState() {
    super.initState();

    _qna = FirebaseFirestore.instance
        .collection("qna")
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).navBarTextQna,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _qna,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty){
              List<QuestionAndAnswer> item = [];
              for (DocumentSnapshot snap in snapshot.data.docs) {
                item.add(QuestionAndAnswer.fromJson(snap.data()));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
                  child: Column(
                    children: [
                      ...item.map((e) => BuildQnaItem(questionAndAnswer: e)),
                      SizedBox(
                        height: getProportionateScreenWidth(24.0),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData && snapshot.data.docs.isEmpty){
              return EmptyQna();
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}

class BuildQnaItem extends StatelessWidget {
  QuestionAndAnswer questionAndAnswer;
  BuildQnaItem({ this.questionAndAnswer });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(36.0)),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).ask,
                            style: TextStyle(fontSize: 14.0, color: kText2, decoration: TextDecoration.none)),
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          questionAndAnswer.question,
                          style: TextStyle(
                              color: kText1,
                              fontSize: 18.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(24.0),
                        ),
                        Text(AppLocalizations.of(context).textAnswer,
                            style: TextStyle(fontSize: 14.0, color: kText2, decoration: TextDecoration.none)),
                        SizedBox(height: getProportionateScreenWidth(8.0)),
                        Text(
                          questionAndAnswer.answer,
                          style: TextStyle(
                              color: kText1,
                              fontFamily: 'Roboto',
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                questionAndAnswer.question,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: kText1, fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(4.0),
              ),
              RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: "${AppLocalizations.of(context).answer}",
                      style: TextStyle(color: kPrimary, fontSize: 14.0),
                      children: [
                        TextSpan(
                            text: "${questionAndAnswer.answer.isEmpty ? AppLocalizations.of(context).pending : questionAndAnswer.answer}",
                            style: TextStyle(color: kPending, fontSize: 14.0))
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyQna extends StatelessWidget {
  const EmptyQna({
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
          "assets/illustrations/emptyqna.svg",
          width: getProportionateScreenWidth(140),
        )),
        SizedBox(
          height: getProportionateScreenHeight(56.0),
        ),
        Center(
            child: Text(
              AppLocalizations.of(context).emptyQnaTitle,
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
                    text: AppLocalizations.of(context).emptyQnaSubtitle,
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
