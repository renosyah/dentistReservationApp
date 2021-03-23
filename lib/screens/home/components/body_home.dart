import 'package:dentistReservationApp/models/Counter.dart';
import 'package:dentistReservationApp/models/QuestionAndAnswer.dart';
import 'package:dentistReservationApp/models/Reservation.dart';
import 'package:dentistReservationApp/models/data_tips_and_tricks.dart';
import 'package:dentistReservationApp/screens/detail/detail_tips_screen.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BodyHome extends StatefulWidget {
  final ValueChanged<int> onTap;
  BodyHome({this.onTap});

  @override
  _BodyHomeState createState() => _BodyHomeState(onTap: this.onTap);
}

class _BodyHomeState extends State<BodyHome> {
  int _currentIndex = 0;
  ValueChanged<int> onTap;
  User user;

  _BodyHomeState({this.onTap});

  carousel.CarouselController _carouselController = carousel.CarouselController();
  TextEditingController _controllerQuestion = TextEditingController();


  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  void _checkCurrentQueue() async {

    var query = await FirebaseFirestore.instance
        .collection("reservation")
        .where('user_id', isEqualTo: user.uid)
        .where('time', isGreaterThan : DateTime.now())
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) return;
    _createQueue();

  }

  void _createQueue(){

    FirebaseFirestore.instance
      .collection("counter")
      .limit(1)
      .get().then((value){
        if (value.docs.isNotEmpty && value.docs[0] != null){
            int counter = value.docs[0].data()['counter_id'];
            DateTime time = value.docs[0].data()['time'].toDate();

            FirebaseFirestore.instance
                .collection("reservation")
                .doc()
                .set(new Reservation(userId : user.uid, queueNumber: counter,name: user.displayName,time: time).toJson());

            FirebaseFirestore.instance
                .collection("counter")
                .doc(value.docs[0].id)
                .set(new Counter(counterId: counter + 1,time: time.add(new Duration(minutes: 30))).toJson());
        }
    });

  }

  void _sendQuestion(){
    if (_controllerQuestion.text.toString().trim().isEmpty){
      print("question must not be empty");
      return;
    }

    // add to document qna
    FirebaseFirestore.instance
        .collection("qna")
        .add(new QuestionAndAnswer(userId:user.uid, question: _controllerQuestion.text.toString(), answer: "", time: DateTime.now()).toJson());

    // question and answer
    Navigator.pop(context);
    this.onTap(2);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    List<TipsAndTrick> _tipsAndTrick = new TipsAndTrick().getListTrickAndTips(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).navBarTextHome,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carousel.CarouselSlider(
            items: new TipsAndTrick().getListTrickAndTips(context).map((data) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailTipsScreen(
                              title: data.title,
                              image: data.image,
                              detailTipAndTrickList: data.tipsAndTrikList,
                            ))),
                child: Container(
                  margin: EdgeInsets.only(
                      left: getProportionateScreenWidth(6.0),
                      top: getProportionateScreenWidth(24.0),
                      right: getProportionateScreenWidth(6.0)),
                  decoration: BoxDecoration(
                      color: kBackground,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(24.0))),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(24.0)),
                        child: Image.asset(
                          data.image,
                          width: double.infinity,
                          height: getProportionateScreenWidth(180.0),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    getProportionateScreenWidth(24.0)),
                                bottomRight: Radius.circular(
                                    getProportionateScreenWidth(24.0)))),
                        child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(16.0)),
                          child: Text(
                            data.title,
                            style: TextStyle(color: kWhite, fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
            options: carousel.CarouselOptions(
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 2),
                height: getProportionateScreenWidth(180.0),
                autoPlay: true,
                enlargeCenterPage: true,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            carouselController: _carouselController,
          ),
          SizedBox(height: getProportionateScreenHeight(16.0)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _tipsAndTrick .map((data) {
                int index = _tipsAndTrick.lastIndexOf(data);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(2.0)),
                  width: _currentIndex == index
                      ? getProportionateScreenHeight(32.0)
                      : getProportionateScreenWidth(8.0),
                  height: getProportionateScreenWidth(8.0),
                  decoration: BoxDecoration(
                      color: _currentIndex == index ? kPrimary : kIndicator,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(8.0))),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(36.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24.0)),
            child: Text(
              AppLocalizations.of(context).features,
              style: TextStyle(
                  color: kText1, fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(16.0),
          ),
          GestureDetector(
            onTap: () { this._checkCurrentQueue(); this.onTap(1); },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
                  child: Container(
                    width: getProportionateScreenWidth(344.0),
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
                      padding:
                          EdgeInsets.all(getProportionateScreenWidth(24.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context).navBarTextReservasi,
                            style: TextStyle(color: kText1, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(4.0),
                          ),
                          Text(
                            AppLocalizations.of(context).subtitleReservasi,
                            style: TextStyle(color: kText2, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 1.0,
                  bottom: 1.0,
                  child: Container(
                    width: getProportionateScreenWidth(44.0),
                    height: getProportionateScreenWidth(44.0),
                    decoration:
                        BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                    child: Icon(
                      Icons.add,
                      color: kWhite,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(24.0),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              getProportionateScreenWidth(24.0)),
                          topRight: Radius.circular(
                              getProportionateScreenWidth(24.0)))),
                  builder: (context) => SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(24.0)),
                          child: Column(
                            // overflowed 41 pixel column
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).asking,
                                style: TextStyle(
                                    color: kText1,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: getProportionateScreenWidth(24.0),
                              ),
                              Form(
                                  child: TextFormField(
                                    controller: _controllerQuestion,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context).askingHint,
                                  filled: true,
                                  fillColor: kBackgroundTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(24.0),
                                      vertical:
                                          getProportionateScreenWidth(16.0)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(8.0))),
                                ),
                              )),
                              SizedBox(
                                height: getProportionateScreenWidth(36.0),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: double.infinity,
                                    height: getProportionateScreenHeight(72.0)),
                                child: ElevatedButton(
                                  onPressed: () { this._sendQuestion(); },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kPrimary),
                                      elevation: MaterialStateProperty.all(0)),
                                  child: Text(
                                    AppLocalizations.of(context).btnSend,
                                    style: TextStyle(
                                      color: kWhite,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
            },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24.0)),
                  child: Container(
                    width: getProportionateScreenWidth(344.0),
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
                      padding:
                          EdgeInsets.all(getProportionateScreenWidth(24.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context).navBarTextQna,
                            style: TextStyle(color: kText1, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(4.0),
                          ),
                          Text(
                            AppLocalizations.of(context).subtitleQna,
                            style: TextStyle(color: kText2, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 1.0,
                  bottom: 1.0,
                  child: Container(
                    width: getProportionateScreenWidth(44.0),
                    height: getProportionateScreenWidth(44.0),
                    decoration:
                        BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                    child: Icon(
                      Icons.add,
                      color: kWhite,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
