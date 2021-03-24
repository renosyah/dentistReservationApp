import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservasiui/utils/colors.dart';
import 'package:reservasiui/utils/size_config.dart';
import 'package:reservasiui/utils/strings.dart';

class CreateReservationScreen extends StatefulWidget {
  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  TextEditingController _textDateController = TextEditingController();
  TextEditingController _textTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          createReservationApp,
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chooseDate,
              style: TextStyle(color: kText2, fontSize: 14.0),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            // field choose date
            Form(
                child: TextFormField(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
              controller: _textDateController,
              focusNode: AlwaysDisabledFocusNode(),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: chooseDate,
                filled: true,
                fillColor: kBackgroundTextField,
                suffixIcon: Icon(Icons.calendar_today_rounded),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0),
                    vertical: getProportionateScreenWidth(16.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(8.0))),
              ),
            )),
            SizedBox(
              height: getProportionateScreenHeight(24.0),
            ),
            Text(
              chooseTime,
              style: TextStyle(color: kText2, fontSize: 14.0),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            // field choose time
            Form(
                child: TextFormField(
              onTap: () {
                _selectTime(context);
              },
              controller: _textTimeController,
              keyboardType: TextInputType.name,
              autofocus: false,
              focusNode: AlwaysDisabledFocusNode(),
              decoration: InputDecoration(
                hintText: chooseTime,
                filled: true,
                fillColor: kBackgroundTextField,
                suffixIcon: Icon(Icons.access_time_rounded),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(24.0),
                    vertical: getProportionateScreenWidth(16.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(8.0))),
              ),
            )),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: double.infinity,
                  height: getProportionateScreenHeight(72.0)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Jadwal reservasi Anda yakni ${_textDateController.text} pukul ${_textTimeController.text}",
                      style: TextStyle(color: kWhite),
                      textAlign: TextAlign.left,
                    ),
                    backgroundColor: kPrimary,
                  ));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimary),
                    elevation: MaterialStateProperty.all(0)),
                child: Text(
                  createReservationApp,
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
    );
  }

  _selectTime(BuildContext context) async {
    TimeOfDay _newSelectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary,
              accentColor: kPrimary,
              colorScheme: ColorScheme.light(primary: kPrimary),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child));
    if (_newSelectedTime != null) {
      _selectedTime = _newSelectedTime;
      _textTimeController
        ..text = _selectedTime.format(context)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textTimeController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDate(BuildContext context) async {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
              day.isBefore(DateTime.now().add(Duration(days: 6)))) &&
          day.weekday != 6 &&
          day.weekday != 7) {
        return true;
      }
      return false;
    }

    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
        selectableDayPredicate: _decideWhichDayToEnable,
        builder: (context, child) => Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary,
              accentColor: kPrimary,
              colorScheme: ColorScheme.light(primary: kPrimary),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child));
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textDateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
