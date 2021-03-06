import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // appbar beserta judul
    return Scaffold(
      appBar: AppBar(
        // menampilkan text atau judul halaman
        title: Text(
          AppLocalizations.of(context).helpApp,
          // memberi style warna, ukuran dan ketebalan pada text
          style: TextStyle(
              color: kPrimary, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      // isi atau content yang ditampilkan
      body: Padding(
        // memberi jarak disegala sisi pada elemen
        padding: EdgeInsets.all(getProportionateScreenWidth(24.0)),
        child: Text(
          // menampilkan text
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          // memberi style ukuran dan warna pada text
          style: TextStyle(color: kText2, fontSize: 16.0),
        ),
      ),
    );
  }
}
