import 'package:flutter/material.dart';
import 'package:tgw_finance_app/tgw_calculator/calculator.dart';
import 'package:tgw_finance_app/tgw_calculator/maincalc.dart';
import 'package:tgw_finance_app/tgw_converter/tgw_convert.dart';
import 'auth.dart';

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
            "Home Page",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text("Calculator"),
                onTap: () => navigateToCalculatorScreen(context),
                trailing: const Icon(Icons.calculate),
              ),
              ListTile(
                title: const Text("Currency Converter"),
                onTap: () => navigateToCurrencyConverterScreen(context),
                trailing: const Icon(Icons.calculate),
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
            hello(),
          ],
        ),
      ),
    );
  }

  Widget hello() {
    return Center(
      child: Text(
        """Hello 
        User${widget.id}""",
        style: const TextStyle(fontSize: 20),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
