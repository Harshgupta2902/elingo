import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/animated_checkboxes.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class DailyStreak extends StatefulWidget {
  const DailyStreak({super.key});

  @override
  State<DailyStreak> createState() => _DailyStreakState();
}

class _DailyStreakState extends State<DailyStreak> with SingleTickerProviderStateMixin {
  final int streakCount = 5;
  final int daysInWeek = 7;
  List<bool> streakStatus = List.generate(7, (index) => false);
  @override
  void initState() {
    super.initState();
    _initializeStreakStatus();
  }

  void _initializeStreakStatus() {
    for (int i = 0; i < streakCount; i++) {
      streakStatus[i] = true;
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        streakStatus[DateTime.now().weekday] = true;
      });
      debugPrint(DateTime.now().weekday.toString());
      debugPrint(streakStatus.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const Text("🔥", style: TextStyle(fontSize: 100)),
                const SizedBox(height: 20),
                Text(
                  "5 Days Streak!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: GlobalColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                ),
                const SizedBox(height: 26),
                Container(
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    borderColor: GlobalColors.borderColor,
                    showShadow: false,
                    borderWidth: 2,
                    borderRadius: 16,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(daysInWeek, (index) {
                          return Column(
                            children: [
                              Text(
                                DateFormat('E').format(
                                  DateTime.now().subtract(
                                    Duration(days: (DateTime.now().weekday - 1 - index) % 7),
                                  ),
                                ),
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              AnimatedCheckBoxes(
                                size: 26,
                                value: streakStatus[index],
                                onChanged: (selected) {},
                                borderRadius: 8,
                              ),
                            ],
                          );
                        }),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: GlobalColors.borderColor, thickness: 1),
                      ),
                      Text(
                        "Increase if you practise every day and will return to zero if you skip a day!",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.battleshipGrey,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: GlobalColors.borderColor,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalColors.secondaryButtonColor,
                      foregroundColor: GlobalColors.primaryColor,
                      elevation: 0),
                  onPressed: () => MyNavigator.pushNamed(GoPaths.shareStreak),
                  child: const Text("SHARE"),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => MyNavigator.pushNamed(GoPaths.allRanks),
                  child: const Text("CONTINUE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
