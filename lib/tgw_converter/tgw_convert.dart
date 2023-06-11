import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tgw_finance_app/tgw_converter/data/theme_data.dart';
import 'package:tgw_finance_app/tgw_converter/pages/home_page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitDown,
//     DeviceOrientation.portraitUp,
//   ]);
//   runApp(const TGWConvert());
// }

class TGWConvert extends StatefulWidget {
  const TGWConvert({Key? key}) : super(key: key);

  @override
  _TGWConvertState createState() => _TGWConvertState();
}

class _TGWConvertState extends State<TGWConvert> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        title: 'SobGOG Currency Converter',
        home: const HomePage(),
        theme: lightModeTheme,
        darkTheme: darkModeTheme,
      );
    });
  }
}
