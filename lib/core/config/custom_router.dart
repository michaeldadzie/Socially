import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/core/screens/bottom_nav_bar.dart';
import 'package:socially/feautures/authentication/presentation/pages/login_screen.dart';
import '../screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case BottomNavBar.routeName:
        return BottomNavBar.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'Error',
            style: GoogleFonts.raleway(color: Colors.black),
          ),
        ),
        body: Center(
          child: Text('Something went wrong',
              style: GoogleFonts.raleway(color: Colors.black, fontSize: 15)),
        ),
      ),
    );
  }
}
