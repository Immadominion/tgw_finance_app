import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tgw_finance_app/screens/profile_screen.dart';
import 'package:tgw_finance_app/tgw_calculator/maincalc.dart';
import 'package:tgw_finance_app/tgw_converter/tgw_convert.dart';

import 'auth_functions_tgw/auth.dart';
import 'tgw_chat_forum/screens/chat_screen.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.auth,
    required this.id,
    required this.onSignOut,
  }) : super(key: key);

  final BaseAuth auth;

  final VoidCallback onSignOut;
  final String id;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [
    const ChatScreen(),
    const TGWConvert(),
    const MainCalcPage(title: 'Calculator'),
    const ProfileScreen(),
  ];

  Future<void> signOutAcc() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logOutNow() {
    return signOutAcc();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TGW Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            userProfile(context),
          ],
        ),
      ),
    );
  }

  Widget userProfile(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            )
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 1500,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == _currentIndex ? 0 : size.width * .029,
                    right: size.width * .042,
                    left: size.width * .042,
                  ),
                  width: size.width * .128,
                  height: index == _currentIndex ? size.width * 0.02 : 0,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      )),
                ),
                Icon(
                  listOfIcons[index],
                  size: size.width * .076,
                  color: index == _currentIndex
                      ? Colors.blueAccent
                      : Colors.black38,
                ),
                SizedBox(
                  height: size.width * .03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_outlined,
    Icons.currency_exchange_rounded,
    Icons.calculate,
    Icons.person_outline,
  ];
}
