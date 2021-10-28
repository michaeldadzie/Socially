import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  static const String routeName = '/nav';
  const BottomNavBar({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (_, __, ___) => BottomNavBar());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('BottomNavBar'),
    );
  }
}
