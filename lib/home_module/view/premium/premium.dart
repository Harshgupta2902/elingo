import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/leaderboard/all_time.dart';
import 'package:vocablury/home_module/view/leaderboard/monthly.dart';
import 'package:vocablury/home_module/view/leaderboard/weekly.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'icon': '🔷',
        'title': "Unlimited Diamonds",
        'subtitle': "Get unlimited diamonds to make the learning process easier."
      },
      {
        'icon': '🕓',
        'title': "Lesson Reminder",
        'subtitle': "Time reminder feature to study, so you never miss it."
      },
      {
        'icon': '🔷',
        'title': "Unlimited Diamonds",
        'subtitle': "Get unlimited diamonds to make the learning process easier."
      },
      {
        'icon': '🕓',
        'title': "Lesson Reminder",
        'subtitle': "Time reminder feature to study, so you never miss it."
      },
      {
        'icon': '🔷',
        'title': "Unlimited Diamonds",
        'subtitle': "Get unlimited diamonds to make the learning process easier."
      },
      {
        'icon': '🕓',
        'title': "Lesson Reminder",
        'subtitle': "Time reminder feature to study, so you never miss it."
      },
      {
        'icon': '🔷',
        'title': "Unlimited Diamonds",
        'subtitle': "Get unlimited diamonds to make the learning process easier."
      },
      {
        'icon': '🕓',
        'title': "Lesson Reminder",
        'subtitle': "Time reminder feature to study, so you never miss it."
      },
    ];
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      appBar: VocabularyAppBar(
        appBgColor: Colors.transparent,
        title: "Premium",
        leadingColor: Colors.white,
        leadingWidget: IconButton(
          onPressed: () {
            MyNavigator.goNamed(GoPaths.dashboardLevels);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 22),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SvgPicture.asset(GlobalImages.smile),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      "Get a better & super fast learning upto 5x with Premium!",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 2,
                          ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 22),
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(cornerRadius: 16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['icon']!,
                              style: const TextStyle(fontSize: 42),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['title']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    data[index]['subtitle']!,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.battleshipGrey,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(color: GlobalColors.borderColor, thickness: 1);
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: GlobalColors.borderColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                MyNavigator.pushNamed(GoPaths.selectPlan);
              },
              child: const Text("Go Premium Now"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.secondaryButtonColor,
                foregroundColor: GlobalColors.primaryColor,
              ),
              onPressed: () => MyNavigator.goNamed(GoPaths.dashboardLevels),
              child: const Text("No Thanks"),
            ),
          ],
        ),
      ),
    );
  }
}
