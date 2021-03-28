import 'dart:convert';

import 'package:dentistReservationApp/models/Counter.dart';
import 'package:dentistReservationApp/models/Reservation.dart';
import 'package:dentistReservationApp/models/data_time.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateReservationScreen extends StatefulWidget {
  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {

  // inisialisasi type data datetime
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  // inisialisasi controller tanggal
  TextEditingController _textDateController = TextEditingController();

  User user;
  Stream<QuerySnapshot> _reservation;

  // fungsi untuk mendapatkan data user
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  // fungsi untuk mendapatkan data reservasi
  void getReservationData() {

    // jika tanggal belum dipilih maka stop!
    if (_selectedDate == null) {

      // query reservasi
      _reservation = FirebaseFirestore.instance
          .collection("reservation")
          .orderBy('time', descending: false)
          .limit(0)
          .snapshots();
      return;
    }

    // query reservasi
    _reservation = FirebaseFirestore.instance
        .collection("reservation")
        .where('time', isGreaterThanOrEqualTo: DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day,8,0,0))
        .where('time', isLessThanOrEqualTo: DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day,17,0,0))
        .orderBy('time', descending: false)
        .limit(20)
        .snapshots();
  }

  // fungsi untuk mendapatkan data reservasi
  // yang sama dengan yg saat ini dibuat
  void _checkCurrentReservation() async {
    if (this._selectedDate == null || this._selectedTime == null) return;

    DateTime reservationTime = new DateTime(
        this._selectedDate.year,
        this._selectedDate.month,
        this._selectedDate.day,
        this._selectedTime.hour,
        this._selectedTime.minute);

    var query = await FirebaseFirestore.instance
        .collection("reservation")
        .where('time', isEqualTo: reservationTime)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      _showDialogFailedCreateReservation("${AppLocalizations.of(context).failedCreateReservationText} ${reservationTime.toString()}");
      return;
    }

    _createReservation(reservationTime);
  }

  // fungsi untuk membuat reservasi
  void _createReservation(DateTime reservationTime) async {
    var query =
        await FirebaseFirestore.instance.collection("counter").limit(1).get();

    if (query.docs.isNotEmpty && query.docs[0] != null) {
      int counter = query.docs[0].data()['counter_id'];

      FirebaseFirestore.instance.collection("reservation").doc().set(
          new Reservation(
                  userId: user.uid,
                  queueNumber: counter,
                  name: user.displayName,
                  time: reservationTime)
              .toJson());

      FirebaseFirestore.instance
          .collection("counter")
          .doc(query.docs[0].id)
          .set(new Counter(counterId: counter + 1).toJson());
    }

    Navigator.pop(context); // ketika diklik akan menutup halaman serta menampilkan snakbar pada halaman beranda
  }

  // fungsi untuk menampilkan dialog
  // gagal reservasi
  Future<void> _showDialogFailedCreateReservation(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).alert),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appbar beserta judul
        appBar: AppBar(
          title: Text(
            // menampilkan judul appbar buat reservasi
            AppLocalizations.of(context).createReservationApp,
            style: TextStyle(
                // memberi style warna ukuran dan ketebalan judul
                color: kPrimary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
            child: Column(
              children: [
                Text(
                  // menampilkan text pilih tanggal
                  AppLocalizations.of(context).chooseDate,
                  // memberi style warna dan ukuran text
                  style: TextStyle(color: kText2, fontSize: 14.0),
                ),
                // memberi jarak antar elemen menggunakan sizebox
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                // field untuk memasukan tanggal
                Form(
                    child: TextFormField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(
                        context); // ketika diklik jalan fungsi selectdate
                  },
                  controller: _textDateController, // controller untuk tanggal
                  focusNode: AlwaysDisabledFocusNode(),
                  decoration: InputDecoration(
                    // menampilkan hint untuk tanggal
                    hintText: AppLocalizations.of(context).chooseDate,
                    filled: true, // mengaktifkan warna
                    fillColor:
                        kBackgroundTextField, // memberi warna pada textformfield
                    suffixIcon: Icon(Icons
                        .calendar_today_rounded), // icon calendar untuk textformfield tanggal
                    contentPadding: EdgeInsets.symmetric(
                        // memberi jarak di kiri dan kanan didalam textformfield
                        horizontal: getProportionateScreenWidth(24.0),
                        vertical: getProportionateScreenWidth(16.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.0,
                            style: BorderStyle
                                .none), // memberi ukuran border dan style
                        borderRadius: BorderRadius.circular(
                            // membuat lengkungan pada textformfield
                            getProportionateScreenWidth(8.0))),
                  ),
                )),
                // membuat jarak antar elemen menggunakan sizebox
                SizedBox(
                  height: getProportionateScreenHeight(24.0),
                ),
                Text(
                  // menampilan text pilih waktu
                  AppLocalizations.of(context).chooseTime,
                  // memberi style warna dan ukuran pada text
                  style: TextStyle(color: kText2, fontSize: 14.0),
                ),
                // membuat jarak antar elemen menggunakan sizebox
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                // field untuk memasukan waktu
                StreamBuilder<QuerySnapshot>(
                    stream: _reservation,
                    builder: (context,snapshot){

                        // deklarasi array
                        var slot = new ChooseTime().create();
                        var now = DateTime.now();

                        // check jika slot telah
                        // di reservasi
                        for (var i=0;i<slot.length;i++){
                          var t = slot[i];

                          // check jika waktu telah lewat
                          if (_selectedDate != null && (now.difference(DateTime(_selectedDate.year ,_selectedDate.month,_selectedDate.day, t.datetime.hour, t.datetime.minute)).inMinutes > 0)){
                            slot[i].status = false;
                            continue;
                          }

                          // check jika waktu jika weekend
                          if (_selectedDate != null && (_selectedDate.weekday == DateTime.sunday || _selectedDate.weekday == DateTime.saturday)){
                            slot[i].status = false;
                            continue;
                          }

                          if (snapshot.hasData){
                            // check setiap reservasi
                            for (var doc in snapshot.data.docs){
                                Reservation r = Reservation.fromJson(doc.data());

                                // jika telah di ambil, set nilai ke false
                                if (r.time.difference(DateTime(r.time.year ,r.time.month,r.time.day, t.datetime.hour, t.datetime.minute)).inMinutes == 0){
                                  slot[i].status = false;
                                }
                            }
                          }

                          if (!slot[i].status) {
                            continue;
                          }
                        }
                        // tampilkan
                        return Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          runSpacing: getProportionateScreenWidth(8.0),
                          spacing: getProportionateScreenWidth(8.0),
                          children: [
                            ...List.generate(
                                slot.length,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (slot[index].status) {
                                        _selectedTime = slot[index].datetime;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: getProportionateScreenWidth(116.0),
                                    height: getProportionateScreenHeight(56.0),
                                    decoration: BoxDecoration(
                                        color: slot[index].status && _selectedTime == slot[index].datetime ? kPrimary  : !slot[index].status ? Colors.red : kWhite,
                                        borderRadius: BorderRadius.circular(
                                            getProportionateScreenWidth(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              blurRadius: 8,
                                              spreadRadius: 4,
                                              offset: Offset(0.0, 0.0),
                                              color: kText1.withOpacity(0.1))
                                        ]),
                                    child: Center(
                                      child: Text(
                                        slot[index].time,
                                        style: TextStyle(
                                            color: slot[index].status && _selectedTime == slot[index].datetime ? kWhite : !slot[index].status ? kWhite : kText2,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        );
                    }
                ),
                // membuat jarak antar elemen menggunakan sizebox
                SizedBox(
                  height: getProportionateScreenHeight(56.0),
                ),
                // tombol untuk buat reservasi
                ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double
                            .infinity, // panjang button mengikuti panjang device
                        height: getProportionateScreenHeight(
                            72.0)), // menentukan tinggi button
                    child: ElevatedButton(
                      onPressed: () {
                        _checkCurrentReservation();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              kPrimary), // memberi warna pada button buat reservasi
                          elevation: MaterialStateProperty.all(
                              0)), // memberi shadow pada button buat reservasi
                      child: Text(
                        // menampilkan text buat reservasi
                        AppLocalizations.of(context).createReservationApp,
                        style: TextStyle(
                          color: kWhite, // memberi warna text
                          fontSize: 22.0, // memberi ukuran text
                          fontWeight: FontWeight.bold, // memberi ketebalan text
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  // funsi untuk menampilkan waktu dalam bentuk timepicker
  _selectDate(BuildContext context) async {
    // menampilkan 5 hari selain sabtu dan minggu dalam 1 minggu
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: 6))))) {
        return true;
      }
      return false;
    }

    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // waktu sekarang
        firstDate: DateTime(2021), // mulai ditahun 2021
        lastDate: DateTime(2030), // berakhir di tahun 2030
        selectableDayPredicate:
            _decideWhichDayToEnable, // jalan fungsi _decideWhichDayToEnable
        builder: (context, child) => Theme(
            // ganti tema
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary, // memberi warna datapicker
              accentColor: kPrimary, // memberi warna datepicker
              colorScheme: ColorScheme.light(
                  primary: kPrimary), // memberi warna datepicker
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme
                      .primary), // memberi warna button datepicker
            ),
            child: child));

    // menampilkan tanggal yang dipilih ke dalam field pilih tanggal
    // jika newSelectedDate tidak sama dengan null
    if (newSelectedDate != null) {
      setState(() {
        // maka _selectedDate diisi dengan nilai newSelectedDate
        _selectedDate = newSelectedDate;

        // query data reservasi
        getReservationData();

      });
      // dan masukan ke dalam controller tanggal dengan format tanggal yang telah ditentukan
      _textDateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textDateController.text.length,
            affinity: TextAffinity.upstream));

    }
  }
}

// kelas untuk me-non-aktif-kan focus pada field
class AlwaysDisabledFocusNode extends FocusNode {
  // ambil fungsi get dari kelas FocusNode dan ubah nilai jadi false
  @override
  bool get hasFocus => false;
}
