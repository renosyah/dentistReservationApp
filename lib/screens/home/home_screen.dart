import 'package:dentistReservationApp/screens/home/components/body_home.dart';
import 'package:dentistReservationApp/screens/profile/profile_screen.dart';
import 'package:dentistReservationApp/screens/qna/qna_screen.dart';
import 'package:dentistReservationApp/screens/reservasi/reservasi_screen.dart';
import 'package:dentistReservationApp/utils/colors.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/strings.dart';
import 'package:dentistReservationApp/utils/notification/notification.dart' as notif;
import 'package:flutter/material.dart';

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

  final _bottomNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.home_filled), label: navBarTextHome),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: navBarTextReservasi),
    BottomNavigationBarItem(
        icon: Icon(Icons.chat_rounded), label: navBarTextQna),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: navBarTextProfile)
  ];

  @override
  void initState() {
    super.initState();
    new notif.Notification().init('events');
    this._listPage = <Widget>[
      BodyHome(onTap: _onNavBarTap),
      ReservasiScreen(),
      QnaScreen(onTap: _onNavBarTap),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
