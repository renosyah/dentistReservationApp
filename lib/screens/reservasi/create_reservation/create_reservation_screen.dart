import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateReservationScreen extends StatefulWidget {
  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  // inisialisasi type data datetime
  DateTime _selectedDate;
  // inisialisasi type timeofday
  TimeOfDay _selectedTime;

  // inisialisasi controller tanggal
  TextEditingController _textDateController = TextEditingController();
  // inisialisasi controller waktu
  TextEditingController _textTimeController = TextEditingController();

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
      body: Padding(
        // memberi jarak disemua sisi elemen
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        // menampilkan elemen secara vertical
        child: Column(
          // memulai elemen dari sisi kiri
          crossAxisAlignment: CrossAxisAlignment.start,
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
                _selectDate(context); // ketika diklik jalan fungsi selectdate
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
            Form(
                child: TextFormField(
              onTap: () {
                _selectTime(
                    context); // jika di klik akan menjalan fungsi selecttime
              },
              controller: _textTimeController, // controller untuk waktu
              autofocus: false, // autofokus diberi nilai false
              focusNode: AlwaysDisabledFocusNode(),
              decoration: InputDecoration(
                // menampilkan text pilih waktu
                hintText: AppLocalizations.of(context).chooseTime,
                filled: true, // mengaktifkan warna textformfield
                fillColor: kBackgroundTextField, // memberi warna textformfield
                suffixIcon:
                    Icon(Icons.access_time_rounded), // memberi icon waktu
                contentPadding: EdgeInsets.symmetric(
                    // memberi jarak di kiri dan kana elemen didalam textformfield
                    horizontal: getProportionateScreenWidth(24.0),
                    vertical: getProportionateScreenWidth(16.0)),
                border: OutlineInputBorder(
                    // memberi border atau bingkai
                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                    // membuat lengkungan pada textformfield
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(8.0))),
              ),
            )),
            // membuat jarak anatar elemen menggunakan spacer
            Spacer(),
            // tombol untuk buat reservasi
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: double
                      .infinity, // panjang button mengikuti panjang device
                  height: getProportionateScreenHeight(
                      72.0)), // menentukan tinggi button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // ketika diklik akan menutup halaman serta menampilkan snakbar pada halaman beranda
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      // menampilkan text pada snakbar
                      "Jadwal reservasi Anda yakni ${_textDateController.text} pukul ${_textTimeController.text}",
                      // memberi style warna pada text
                      style: TextStyle(color: kWhite),
                      // posisi text berada dikiri
                      textAlign: TextAlign.left,
                    ),
                    backgroundColor: kPrimary, // memberi warna pada snackbar
                  ));
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // funsi untuk menampilkan tanggal dalam bentuk datepicker
  _selectTime(BuildContext context) async {
    TimeOfDay _newSelectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), // inisialisasi waktu sekarang
        builder: (context, child) => Theme(
            // ubah tema
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary, // memberi warna pada timepicker
              accentColor: kPrimary, // memberi warna pada timepicker
              colorScheme: ColorScheme.light(
                  primary: kPrimary), // memberi warna pada timepicker
              buttonTheme: ButtonThemeData(
                  textTheme:
                      ButtonTextTheme.primary), // memberi warna pada timepicker
            ),
            child: child));

    // menampilkan waktu yang dipilih ke dalam field pilih waktu
    // jika -newselectedTime tidak sam dengan null
    if (_newSelectedTime != null) {
      // maka variable _selectedTime diisi nilai _newselectedtime
      _selectedTime = _newSelectedTime;
      // dan masukan ke dalam controller waktu dengan format dan panjang yang telah ditentukan
      _textTimeController
        ..text = _selectedTime.format(context)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textTimeController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  // funsi untuk menampilkan waktu dalam bentuk timepicker
  _selectDate(BuildContext context) async {
    // menampilkan 5 hari selain sabtu dan minggu dalam 1 minggu
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
              day.isBefore(DateTime.now().add(Duration(days: 6)))) &&
          day.weekday != 6 && // bukan hari sabtu
          day.weekday != 7) {
        // bukan hari minggu
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
      // maka _selectedDate diisi dengan nilai newSelectedDate
      _selectedDate = newSelectedDate;
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
