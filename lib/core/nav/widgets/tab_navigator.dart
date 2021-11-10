import 'package:flutter/material.dart';
import 'package:socially/core/config/custom_router.dart';
import 'package:socially/core/nav/enums/bottom_nav_item.dart';
import 'package:socially/features/create/presentation/pages/create_screen.dart';
import 'package:socially/features/feed/presentation/pages/feed_screen.dart';
import 'package:socially/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:socially/features/profile/presentation/pages/profile_screen.dart';
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
        return FeedScreen();
      case BottomNavItem.search:
        return SearchScreen();
      case BottomNavItem.create:
        return CreateScreen();
      case BottomNavItem.notifications:
        return NotificationsScreen();
      case BottomNavItem.profile:
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }
}