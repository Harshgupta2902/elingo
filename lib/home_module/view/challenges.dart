import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/challenges/badges.dart';
import 'package:vocablury/home_module/view/challenges/target.dart';
import 'package:vocablury/home_module/view/leaderboard/all_time.dart';
import 'package:vocablury/home_module/view/leaderboard/monthly.dart';
import 'package:vocablury/home_module/view/leaderboard/weekly.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VocabularyAppBar(
        title: "Challenges",
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                indicator: BoxDecoration(
                    color: GlobalColors.primaryColor, borderRadius: BorderRadius.circular(24)),
                labelStyle:
                    Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                labelColor: Colors.white,
                unselectedLabelColor: GlobalColors.primaryColor,
                dividerColor: Colors.transparent,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.primaryColor),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                    child: const Center(
                      child: Text("Target"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.primaryColor),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                    child: const Center(
                      child: Text("Badges"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TargetChallenges(),
                    BadgesChallenges(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
