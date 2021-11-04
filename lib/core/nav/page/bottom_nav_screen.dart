import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/core/nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:socially/core/nav/enums/bottom_nav_item.dart';
import 'package:socially/core/nav/widgets/bottom_nav_bar.dart';
import 'package:socially/core/nav/widgets/tab_navigator.dart';

class BottomNavScreen extends StatelessWidget {
  static const String routeName = '/nav';
  BottomNavScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavBarCubit>(
        create: (_) => BottomNavBarCubit(),
        child: BottomNavScreen(),
      ),
    );
  }

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.feed: GlobalKey<NavigatorState>(),
    BottomNavItem.search: GlobalKey<NavigatorState>(),
    BottomNavItem.create: GlobalKey<NavigatorState>(),
    BottomNavItem.notifications: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = {
    BottomNavItem.feed: Icons.home,
    BottomNavItem.search: Icons.search,
    BottomNavItem.create: Icons.add,
    BottomNavItem.notifications: Icons.favorite_border,
    BottomNavItem.profile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
                children: items
                    .map(
                      (item, _) => MapEntry(
                        item,
                        _buildOffStageNavigator(
                            item, item == state.selectedItem),
                      ),
                    )
                    .values
                    .toList()),
            bottomNavigationBar: BottomNavBar(
              items: items,
              onTap: (index) {
                final selectedItem = BottomNavItem.values[index];

                _selectedBottomNavItem(
                  context,
                  selectedItem,
                  selectedItem == state.selectedItem,
                );
              },
              selectedItem: state.selectedItem,
            ),
          );
        },
      ),
    );
  }

  void _selectedBottomNavItem(
    BuildContext context,
    BottomNavItem selectedItem,
    bool isSameItem,
  ) {
    if (isSameItem) {
      navigatorKeys[selectedItem]
          ?.currentState
          ?.popUntil((route) => route.isFirst);
    }
    context.read<BottomNavBarCubit>().updateSelectedItem(selectedItem);
  }

  Widget _buildOffStageNavigator(BottomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem],
        item: currentItem,
      ),
    );
  }
}
