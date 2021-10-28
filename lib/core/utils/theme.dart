import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Constants {
  static String appName = "Socially";

  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;

  static Color primaryBlue = const Color.fromRGBO(19, 119, 188, 1);
  static Color secondaryBlue = const Color.fromRGBO(41, 170, 225, 1);
  static Color tertiaryBlue = const Color.fromRGBO(37, 32, 91, 1);
  static Color primaryWhite = const Color.fromRGBO(247, 247, 247, 1);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    accentColor: lightPrimary,
    scaffoldBackgroundColor: primaryWhite,
    focusColor: primaryBlue,
    hintColor: tertiaryBlue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    accentColor: darkPrimary,
    scaffoldBackgroundColor: primaryWhite,
    focusColor: primaryBlue,
    hintColor: tertiaryBlue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );
}
