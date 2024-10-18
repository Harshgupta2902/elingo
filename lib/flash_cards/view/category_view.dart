import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class FlashCardCategoryView extends StatelessWidget {
  final List? routesData;

  FlashCardCategoryView({
    super.key,
    this.routesData,
  });

  final keyValue = [
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
  ];

  final bgColors = [
    AppColors.lavenderMist,
    AppColors.tequila,
    AppColors.aeroBlue,
  ];

  final borderColorsList = [
    AppColors.pastelBlue,
    AppColors.sand,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisExtent: 100,
        mainAxisSpacing: 25,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: keyValue.length,
      itemBuilder: (context, index) {
        final item = keyValue[index];
        final route = routesData?[index];

        final backColors = bgColors[index];
        final borderColors = borderColorsList[index];

        return GestureDetector(
          onTap: () {
            context.pop();
            context.push(
              "/${route.path}",
              extra: {
                "dbName": route.value,
                "title": route.key,
              },
            );
          },
          child: Container(
            decoration: AppBoxDecoration.getBorderBoxDecoration(
              color: backColors,
              borderRadius: 18,
              borderColor: borderColors,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.key,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brightGrey,
                          ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Lottie.asset(
                        item.path.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.brightGrey,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
