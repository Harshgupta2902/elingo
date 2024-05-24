import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

class TakeTest extends StatelessWidget {
  const TakeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        borderColor: Colors.transparent,
        color: AppColors.brightGold,
        borderRadius: 14,
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Master Your Grammar: Test Your English Proficiency! ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.balticSea,
                        ),
                  ),
                ),
                Text(
                  "Get your result evaluated 1:1",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.balticSea,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton(
              style: getOutlinedButtonStyle(
                borderRadius: 10,
                showShadow: false,
                width: MediaQuery.of(context).size.width * 0.1,
                height: 40,
                backgroundColor: AppColors.white,
                borderColor: AppColors.white,
              ),
              onPressed: () {
                context.push(
                  GoPaths.chooseMockTestScreen,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Take Test",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.balticSea,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
