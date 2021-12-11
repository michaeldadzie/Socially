import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/core/screens/screens.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/authentication/presentation/pages/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.satus == AuthStatus.unauthenticated) {
            //Go to login screen
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state.satus == AuthStatus.authenticated) {
            // Go to home screen
            Navigator.of(context).pushNamed(BottomNavScreen.routeName);
          }
          print(state);
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
