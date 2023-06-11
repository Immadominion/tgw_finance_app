import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightModeTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  secondaryHeaderColor: const Color(0xff3b22a1),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(color: Colors.black),
  ),
  cardColor: Colors.white,
  colorScheme: const ColorScheme(
    background: Color(0xfff8f8f8),
    brightness: Brightness.light,
    error: Colors.redAccent,
    onBackground: Colors.black87,
    onError: Colors.black87,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    primary: Colors.white,
    secondary: Colors.white60,
    surface: Colors.white70,
  ),
);
ThemeData darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  secondaryHeaderColor: const Color(0xff3b22a1),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(color: Colors.white),
  ),
  cardColor: const Color(0xff070606),
  colorScheme: const ColorScheme(
      background: Color(0xff06090d),
      brightness: Brightness.dark,
      error: Colors.redAccent,
      onBackground: Colors.white70,
      onError: Colors.blueAccent,
      onPrimary: Colors.black87,
      onSecondary: Colors.black54,
      onSurface: Colors.black,
      primary: Colors.black54,
      secondary: Colors.black38,
      surface: Colors.black12),
);
