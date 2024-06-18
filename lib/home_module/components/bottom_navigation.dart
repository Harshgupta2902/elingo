import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final dat = GoRouterState.of(context).matchedLocation;
    setState(() {
      index = _getIndexFromPath(dat);
    });
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
        _onItemTapped(idx, context);
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

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go(GoPaths.dashboardLevels);
      break;
    case 1:
      context.go(GoPaths.leaderBoard);
      break;
    case 2:
      context.go(GoPaths.challenges);
      break;
    case 3:
      context.go(GoPaths.premium);
      break;
    case 4:
      context.go(GoPaths.profile);
      break;
    default:
      context.go(GoPaths.dashboardLevels);
  }
}

int _getIndexFromPath(String path) {
  switch (path) {
    case GoPaths.dashboardLevels:
      return 0;
    case GoPaths.leaderBoard:
      return 1;
    case GoPaths.challenges:
      return 2;
    case GoPaths.profile:
      return 4;
    default:
      return 0;
  }
}
