import 'package:flutter/material.dart';

class Constants {
  static String appName = "Socially";

  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;

  static Color primaryBlue = const Color.fromRGBO(19, 119, 188, 1);
  static Color secondaryBlue = const Color.fromRGBO(41, 170, 225, 1);
  static Color tertiaryBlue = const Color.fromRGBO(37, 32, 91, 1);
  static Color primaryWhite = const Color.fromRGBO(247, 247, 247, 1);

  static Color primaryGrey = Colors.grey.shade200;
  static Color secondaryGrey = Colors.grey.shade900;
  static Color tertiaryGrey = Colors.grey.shade50;
  static Color darkGrey = Colors.grey.shade600;
  static Color profileGrey = Colors.grey.shade400;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: lightPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: darkPrimary)),
    // brightness: Brightness.light,
    backgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightPrimary),
    scaffoldBackgroundColor: lightPrimary,
    focusColor: darkPrimary,
    hoverColor: primaryGrey,
    hintColor: primaryGrey,
    dividerColor: primaryGrey,
    splashColor: lightPrimary,
    shadowColor: profileGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: darkPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: lightPrimary)),
    // brightness: Brightness.dark,
    backgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkPrimary),
    scaffoldBackgroundColor: darkPrimary,
    focusColor: lightPrimary,
    hoverColor: secondaryGrey,
    hintColor: secondaryGrey,
    dividerColor: tertiaryGrey,
    splashColor: darkPrimary,
    shadowColor: darkGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );
}
