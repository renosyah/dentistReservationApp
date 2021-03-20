import 'package:flutter/material.dart';
import 'package:dentistReservationApp/utils/constantas.dart';
import 'package:dentistReservationApp/utils/size_config.dart';
import 'package:dentistReservationApp/utils/notification/notification.dart' as notif;
import 'components/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
    new notif.Notification().init('events');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final _listPage = <Widget>[
      HomeBody(),
      HomeBody(),
    ];

    final _builItemBottomNavBar = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
    ];

    final _buildBottomNavBar = BottomNavigationBar(
        backgroundColor: kCardColor,
        elevation: 16.0,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: kSubtitleTextColor,
        items: _builItemBottomNavBar,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        });

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          child: _buildBottomNavBar,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(getProportionateScreenWidth(16.0)),
            topRight: Radius.circular(getProportionateScreenWidth(16.0)),
          ),
        ),
        body: Center(
          child: _listPage[_currentIndex],
        ),
      ),
    );
  }
}
