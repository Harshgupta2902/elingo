import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/leaderboard/all_time.dart';
import 'package:vocablury/home_module/view/leaderboard/monthly.dart';
import 'package:vocablury/home_module/view/leaderboard/weekly.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      appBar: VocabularyAppBar(
        appBgColor: Colors.transparent,
        title: "Leaderboard",
        leadingWidget: SvgPicture.asset(GlobalImages.smile),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                indicator:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                labelStyle:
                    Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                labelColor: GlobalColors.primaryColor,
                unselectedLabelColor: Colors.white,
                dividerColor: Colors.transparent,
                tabs: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Tab(
                      child: Text('Weekly'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Tab(
                      child: Text('Monthly'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: const Tab(
                      child: Text('All Time'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    WeeklyLeaderBoard(),
                    MonthlyLeaderBoard(),
                    AllTimeLeaderBoard(),
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
