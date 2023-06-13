import 'package:flutter/material.dart';

import 'package:tgw_finance_app/screens/profile_screen.dart';

import 'package:tgw_finance_app/tgw_calculator/maincalc.dart';
import 'package:tgw_finance_app/tgw_converter/tgw_convert.dart';
import 'auth_functions_tgw/auth.dart';
import 'constants.dart';
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

  void navigateToCalculatorScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainCalcPage(
          title: 'TGW Calculator',
        ),
      ),
    );
  }

  void navigateToForum(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      ),
    );
  }

  void navigateToCurrencyConverterScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TGWConvert(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/Calculator': (context) => const MainCalcPage(title: 'TGW Calculator'),
      //   // '/pg3': (context) => ThirdScreen(),
      //   // '/abt': (context) => AboutScreen(),
      // },
      title: 'TGW Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set default text direction to LTR
      // You can also set this to RTL if your app's default text direction is right-to-left
      // textDirection: TextDirection.ltr,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile Page",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color.fromARGB(255, 250, 181, 181),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text("Forum"),
                onTap: () => navigateToForum(context),
                trailing: const Icon(Icons.chat_outlined),
              ),
              ListTile(
                title: const Text("Calculator"),
                onTap: () => navigateToCalculatorScreen(context),
                trailing: const Icon(Icons.calculate),
              ),
              ListTile(
                title: const Text("Currency Converter"),
                onTap: () => navigateToCurrencyConverterScreen(context),
                trailing: const Icon(Icons.currency_exchange_rounded),
              ),
              ListTile(
                title: const Text("Logout"),
                onTap: signOutAcc,
                trailing: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            userProfile(),
          ],
        ),
      ),
    );
  }

  Widget userProfile() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30.0,
        backgroundColor: kNextIconColor,
        fixedColor: kColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: kNextIconColor,
            tooltip: 'Home',
            icon: Icon(Icons.home_outlined, color: kColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: kNextIconColor,
            icon: Icon(Icons.currency_exchange_rounded, color: kColor),
            label: 'Convert Currency',
          ),
          BottomNavigationBarItem(
            backgroundColor: kNextIconColor,
            icon: Icon(Icons.calculate, color: kColor),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            backgroundColor: kNextIconColor,
            icon: Icon(Icons.person_outline, color: kColor),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}




// Center(
//       child: Text(
//         """Hello 
//         User${widget.id}""",
//         style: const TextStyle(fontSize: 20),
//         textDirection: TextDirection.ltr,
//       ),
//     );
