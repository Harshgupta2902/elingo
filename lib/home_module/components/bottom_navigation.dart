import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: GlobalColors.primaryColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (idx) {
        setState(() {
          index = idx;
          debugPrint('$idx');
        });
        _onItemTapped(idx);
      },
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          label: 'Leaderboard',
          icon: Icon(Icons.leaderboard_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Challenge',
          icon: Icon(Icons.credit_card_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Premium',
          icon: Icon(Icons.star_border),
        ),
        BottomNavigationBarItem(
          label: 'Account',
          icon: Icon(Icons.person_outline),
        ),
      ],
    );
  }
}

void _onItemTapped(int index) {
  switch (index) {
    case 0:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
      break;
    case 1:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
      break;
    case 2:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
      break;
    case 3:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
      break;
    case 4:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
      break;
    default:
      MyNavigator.pushNamed(GoPaths.dashboardLevels);
  }
}
