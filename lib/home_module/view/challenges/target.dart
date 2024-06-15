import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class TargetChallenges extends StatefulWidget {
  const TargetChallenges({super.key});

  @override
  State<TargetChallenges> createState() => _TargetChallengesState();
}

class _TargetChallengesState extends State<TargetChallenges> {
  static const missionUpdates = [
    {'image': '🔷', 'name': 'Get 25 Diamonds', 'total': '25', 'achieved': '12'},
    {'image': '⚡', 'name': 'Get 40 XP', 'total': '40', 'achieved': '24'},
    {'image': '🎯', 'name': 'Get 2 perfect lessons', 'total': '2', 'achieved': '0'},
    {'image': '🔥', 'name': 'Complete 1 Challenge', 'total': '1', 'achieved': '1'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Missions 🎯",
                style:
                    Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Icon(
                Icons.arrow_right_alt_rounded,
                color: GlobalColors.primaryColor,
                size: 30,
              )
            ],
          ),
          ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: missionUpdates.length,
            itemBuilder: (context, index) {
              double? total = double.tryParse(missionUpdates[index]['total']?.toString() ?? '');
              double? achieved =
                  double.tryParse(missionUpdates[index]['achieved']?.toString() ?? '');
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 16),
                    side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      missionUpdates[index]['image']!,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            missionUpdates[index]['name']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: LinearProgressIndicator(
                                  color: GlobalColors.primaryColor,
                                  backgroundColor: GlobalColors.borderColor,
                                  value: achieved! / total!,
                                  minHeight: 8,
                                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${(achieved.toInt())} / ${total.toInt()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: GlobalColors.primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Challenge Events 📆",
                style:
                    Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Icon(
                Icons.arrow_right_alt_rounded,
                color: GlobalColors.primaryColor,
                size: 30,
              )
            ],
          ),
          ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: AppBoxDecoration.getBorderBoxDecoration(
                  borderColor: GlobalColors.borderColor,
                  showShadow: false,
                  borderRadius: 24,
                ),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.sunShade,
                        borderRadius: SmoothBorderRadius.vertical(
                          top: SmoothRadius(cornerRadius: 22, cornerSmoothing: 1.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 32),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Competition",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Elingo Match!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Earn 2000 XP  and get a special bonus from ${GlobalText.appName}",
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(GlobalImages.smile),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            color: GlobalColors.primaryColor,
                            backgroundColor: GlobalColors.borderColor,
                            value: (872 / 2000),
                            minHeight: 12,
                            borderRadius: SmoothBorderRadius(cornerRadius: 22),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "872 / 2000",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: GlobalColors.primaryColor, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "3 days left",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.battleshipGrey, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(color: GlobalColors.borderColor, thickness: 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Take the Challenge",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: GlobalColors.primaryColor,
                                size: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 20),
        ],
      ),
    );
  }
}
