import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socially/features/feed/presentation/cubit/liked_post_cubit.dart';
import 'core/screens/screens.dart';
import 'core/utils/screen_sizes.dart';
import 'core/utils/theme.dart';
import 'core/config/custom_router.dart';
import 'features/authentication/presentation/bloc/simple_bloc_observer.dart';
import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'features/profile/data/repositories/user/user_repository.dart';
import 'features/create/data/repositories/post_repository.dart';
import 'features/profile/data/repositories/storage/storage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleClassObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(Socially());
}

class Socially extends StatelessWidget {
  const Socially({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        RepositoryProvider<PostRepository>(
          create: (_) => PostRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LikedPostCubit>(
            create: (context) => LikedPostCubit(
              postRepository: context.read<PostRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          )
        ],
        child: ScreenUtilInit(
          designSize: Size(
            MyScreenSizes.screenWidth,
            MyScreenSizes.screenHeight,
          ),
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Constants.lightTheme,
              darkTheme: Constants.darkTheme,
              onGenerateRoute: CustomRouter.onGenerateRoute,
              initialRoute: SplashScreen.routeName,
            );
          },
        ),
      ),
    );
  }
}
