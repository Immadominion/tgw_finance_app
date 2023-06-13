import 'package:flutter/material.dart';
import 'package:tgw_finance_app/screens/flash_screen.dart';
import 'package:tgw_finance_app/snap_error.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tgw_finance_app/firebase_options.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const FlashScreen();
            } else if (snapshot.hasError) {
              return const SnapshotErrorPage();
            } else {
              return const SpinKitWaveSpinner(
                color: Color.fromARGB(255, 244, 77, 74),
              );
            }
          }),
    );
  }
}
