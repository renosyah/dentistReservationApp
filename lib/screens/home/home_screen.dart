import 'package:dentistReservationApp/screens/home/components/body_home.dart';
import 'package:dentistReservationApp/screens/profile/profile_screen.dart';
import 'package:dentistReservationApp/screens/qna/qna_screen.dart';
import 'package:dentistReservationApp/screens/reservasi/reservasi_screen.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/notification/notification.dart'
    as notif;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _listPage;

  @override
  void initState() {
    super.initState();
    new notif.Notification().init('events');

    // inisialisasi kumpulan screen pada bottom navbar
    this._listPage = <Widget>[
      BodyHome(onTap: _onNavBarTap),
      ReservasiScreen(),
      QnaScreen(onTap: _onNavBarTap),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    // inisialisasi ukuran smartphone dari class SizeConfig
    SizeConfig().init(context);

    // bottom navbar
    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: AppLocalizations.of(context).navBarTextHome),
      BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: AppLocalizations.of(context).navBarTextReservasi),
      BottomNavigationBarItem(
          icon: Icon(Icons.chat_rounded),
          label: AppLocalizations.of(context).navBarTextQna),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppLocalizations.of(context).navBarTextProfile)
    ];

    return Scaffold(
      body: _listPage[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kWhite,
        elevation: 4,
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
        showSelectedLabels: false,
        selectedItemColor: kPrimary,
        unselectedItemColor: kIndicator,
        items: _bottomNavBarItems,
      ),
    );
  }
}
