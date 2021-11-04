import 'package:flutter/material.dart';
import 'package:socially/core/nav/enums/bottom_nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).focusColor,
        unselectedItemColor: Colors.grey,
        currentIndex: BottomNavItem.values.indexOf(selectedItem),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTap,
        items: items
            .map(
              (item, icon) => MapEntry(
                item.toString(),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(icon),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
