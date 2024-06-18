import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class BadgesChallenges extends StatefulWidget {
  const BadgesChallenges({super.key});

  @override
  State<BadgesChallenges> createState() => _BadgesChallengesState();
}

class _BadgesChallengesState extends State<BadgesChallenges> {
  final List<String> badgeNames = ["Quiz King", "Math Master", "Science Star", "History Hero"];
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  final Random random = Random();

  final data = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> generateRandomData() {
    return List.generate(3, (yearIndex) {
      int badgeCount = 3 + random.nextInt(3);
      return {
        'year': '202${yearIndex + 1}',
        'badges': List.generate(badgeCount, (badgeIndex) {
          return {
            'badge': "",
            'badge_name': badgeNames[random.nextInt(badgeNames.length)],
            'month': months[random.nextInt(months.length)],
            "xp": (1000 + random.nextInt(2000)).toString(),
          };
        }),
      };
    });
  }

  @override
  void initState() {
    super.initState();
    data.addAll(generateRandomData());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, yearIndex) {
              final yearData = data[yearIndex];
              final year = yearData['year'];
              final badges = yearData['badges'] as List<Map<String, String>>;
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 16),
                    side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          year,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${badges.length} Badges",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.battleshipGrey,
                              ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: GlobalColors.borderColor, thickness: 1),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      itemCount: badges.length,
                      itemBuilder: (context, badgeIndex) {
                        final badge = badges[badgeIndex];

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: ShapeDecoration(
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(cornerRadius: 16),
                              // side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    clipBehavior: Clip.hardEdge,
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                      height: 56,
                                      width: 56,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        badge['badge_name']!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${badge['month']} · ${badge['xp']} XP",
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.battleshipGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.battleshipGrey,
                                  )
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
