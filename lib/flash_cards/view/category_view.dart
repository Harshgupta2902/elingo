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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Category Name',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.brightGrey,
                ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
          ),
          itemCount: keyValue.length,
          itemBuilder: (context, index) {
            final item = keyValue[index];
            final route = routesData?[index];

            final backColors = bgColors[index];
            final borderColors = borderColorsList[index];

            return GestureDetector(
              onTap: () {
                context.push(
                  "/${route.path}",
                  extra: {
                    "dbName": route.value,
                    "title": route.key,
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                width: 160,
                decoration: AppBoxDecoration.getBorderBoxDecoration(
                  color: backColors ,
                  borderRadius: 18,
                  showShadow: false,
                  borderColor: borderColors ,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        item.key ,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.brightGrey,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.value ,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.brightGrey,
                            ),
                      ),
                      Lottie.asset(
                        item.path.toString(),
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
