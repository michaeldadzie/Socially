import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/core/config/custom_router.dart';
import 'package:socially/core/nav/enums/bottom_nav_item.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/create/data/repositories/post_repository.dart';
import 'package:socially/features/create/presentation/cubit/create_post_cubit.dart';
import 'package:socially/features/create/presentation/pages/create_screen.dart';
import 'package:socially/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:socially/features/feed/presentation/pages/feed_screen.dart';
import 'package:socially/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:socially/features/profile/data/repositories/storage/storage_repository.dart';
import 'package:socially/features/profile/data/repositories/user/user_repository.dart';
import 'package:socially/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:socially/features/profile/presentation/pages/profile_screen.dart';
import 'package:socially/features/search/presentation/cubit/search_cubit.dart';
import 'package:socially/features/search/presentation/pages/search_screen.dart';

class TabNavigator extends StatelessWidget {
  static const String? tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState>? navigatorKey;
  final BottomNavItem? item;

  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders![initialRoute]!(context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String?, WidgetBuilder?>? _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem? item) {
    switch (item) {
      case BottomNavItem.feed:
        return BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            postRepository: context.read<PostRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..add(FeedFetchPosts()),
          child: FeedScreen(),
        );
      case BottomNavItem.search:
        return BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(
            userRepository: context.read<UserRepository>(),
          ),
          child: SearchScreen(),
        );
      case BottomNavItem.create:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
            postRepository: context.read<PostRepository>(),
            storageRepository: context.read<StorageRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
          child: CreateScreen(),
        );
      case BottomNavItem.notifications:
        return NotificationsScreen();
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
            postRepository: context.read<PostRepository>(),
          )..add(ProfileLoadUser(
              userId: context.read<AuthBloc>().state.user!.uid)),
          child: ProfileScreen(),
        );
      default:
        return const Scaffold();
    }
  }
}
