import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

String darkText = 'DarkText';
String lightText = 'LightText';

PreferredSize appbarWidget(ThemeData themeData) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40.0), //appbar size
    child: AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.colorScheme.background,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Image.asset(
        themeData.brightness == Brightness.light
            ? 'assets/images/tgwconvert.png'
            : 'assets/images/tgwconvert.png',
        height: 15.5.h,
      ),
      centerTitle: true,
    ),
  );
}
