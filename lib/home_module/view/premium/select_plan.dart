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

class SelectPlan extends StatefulWidget {
  const SelectPlan({super.key});

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  final data = [
    {'title': "1 Month", 'subtitle': "Get over 10% off", 'price': "\$ 10.00"},
    {
      'title': "3 Months",
      'subtitle': "Get over 15% off",
      'price': "\$ 27.00" // Assuming $9 per month
    },
    {
      'title': "6 Months",
      'subtitle': "Get over 20% off",
      'price': "\$ 48.00" // Assuming $8 per month
    },
    {
      'title': "12 Months",
      'subtitle': "Get over 25% off",
      'price': "\$ 90.00" // Assuming $7.50 per month
    }
  ];
  int selectedPlan = -1;
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 22),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Choose a subscription Plan",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: GlobalColors.borderColor, thickness: 1),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPlan = index;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: ShapeDecoration(
                            color: selectedPlan == index ? GlobalColors.secondaryButtonColor : null,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(cornerRadius: 16),
                              side: BorderSide(
                                  color: selectedPlan == index
                                      ? GlobalColors.primaryColor
                                      : GlobalColors.borderColor,
                                  width: 2),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
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
                                  Text(
                                    data[index]['price']!,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: GlobalColors.primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                  ),
                ],
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
        child: ElevatedButton(
          onPressed: () {
            MyNavigator.pushNamed(GoPaths.selectPayment);
          },
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
