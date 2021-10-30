import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/core/screens/screens.dart';
import 'package:socially/core/utils/theme.dart';
import 'package:socially/features/authentication/presentation/bloc/simple_bloc_observer.dart';
import 'package:socially/features/authentication/data/repositories/auth_repository.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'core/config/custom_router.dart';
import 'core/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleClassObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(Socially());
}

class Socially extends StatelessWidget {
  Socially({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.lightTheme,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
