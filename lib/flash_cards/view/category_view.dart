import 'package:flutter/material.dart';
import 'package:vocablury/dashboard_module/componants/dashboard_custom_components.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class FlashCardCategoryView extends StatelessWidget {
  final List? categoryName;

  FlashCardCategoryView({
    super.key,
    this.categoryName,
  });

  final bgColors = [
    AppColors.lavenderMist,
    AppColors.tequila,
    AppColors.aeroBlue,
    AppColors.moonRaker,
    AppColors.tequila,
    AppColors.aeroBlue,
  ];

  final borderColorsList = [
    AppColors.pastelBlue,
    AppColors.sand,
    AppColors.lightBluishGreen,
    AppColors.babyPurple,
    AppColors.sand,

    AppColors.lightBluishGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Category Name',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.brightGrey,
                ),
          ),
        ),
        buildGridTestContainers(
          context: context,
          value: [
            KeyValuePair(
              key: "Liked ",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.saveJson,
            ),
            KeyValuePair(
              key: "Saved",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.saveJson,
            ),
            KeyValuePair(
              key: "Noun",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.saveJson,
            ),
            KeyValuePair(
              key: "Adjective",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.likedJson,
            ),
            KeyValuePair(
              key: "Verb",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.likedJson,
            ),
            KeyValuePair(
              key: "Adverb",
              value: "Practice Makes a Man Perfect!",
              path: AssetPath.saveJson,
            ),
          ],
          bgColors: bgColors,
          borderColorsList: borderColorsList,
        ),
      ],
    );
  }
}
