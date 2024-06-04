import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/components/single_calender.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/flexible_dropdown.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class CommonFlexibleDropdown extends StatelessWidget {
  final Widget child;
  final Widget overlayChild;
  final double height;
  final Color color;
  final Duration duration;
  final AnimationType animationType;
  final BarrierShape barrierShape;

  const CommonFlexibleDropdown({
    Key? key,
    required this.child,
    this.height = 160,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 400),
    this.animationType = AnimationType.size,
    this.barrierShape = BarrierShape.headerTrans,
    required this.overlayChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleDropdown(
      overlayChild: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: color,
        child: overlayChild,
      ),
      barrierColor: Colors.black.withOpacity(0.8),
      barrierShape: barrierShape,
      duration: duration,
      animationType: animationType,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: child,
      ),
    );
  }
}

class DashBoardAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DashBoardAppBar({super.key});

  @override
  State<DashBoardAppBar> createState() => _DashBoardAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _DashBoardAppBarState extends State<DashBoardAppBar> {
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white);
    return Container(
      color: GlobalColors.appBarColorBlue,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonFlexibleDropdown(
                overlayChild: const LanguageDropDown(),
                child: Row(
                  children: [
                    Text("🇺🇸", style: style),
                    Text("  EN", style: style),
                  ],
                ),
              ),
              CommonFlexibleDropdown(
                overlayChild: const StreakDropDown(),
                height: 150,
                child: Row(
                  children: [
                    Text("🔥", style: style),
                    Text("  4", style: style),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => MyNavigator.pushNamed(GoPaths.buyDiamonds),
                child: Row(
                  children: [
                    Text("🔷", style: style),
                    Text("  957", style: style),
                  ],
                ),
              ),
              CommonFlexibleDropdown(
                overlayChild: const SizedBox(height: 40),
                height: 150,
                child: Text("🌟", style: style),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 100,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: SmoothBorderRadius(cornerRadius: 16),
              ),
              child: Image.network(
                  "https://raw.githubusercontent.com/vanshg395/intl_phone_field/master/assets/flags/us.png",
                  fit: BoxFit.fill),
            ),
            const SizedBox(height: 10),
            Text(
              "English",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 100,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: SmoothBorderRadius(cornerRadius: 16),
              ),
              child: Image.network(
                  "https://raw.githubusercontent.com/vanshg395/intl_phone_field/master/assets/flags/es.png",
                  fit: BoxFit.fill),
            ),
            const SizedBox(height: 10),
            Text(
              "Spanish",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: SmoothBorderRadius(cornerRadius: 16),
                border: Border.all(color: GlobalColors.borderColor, width: 2),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Add",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ],
    );
  }
}

class StreakDropDown extends StatelessWidget {
  const StreakDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Challenges (day)",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "4/14",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.battleshipGrey),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          color: GlobalColors.primaryColor,
          backgroundColor: GlobalColors.borderColor,
          value: 0.42,
          minHeight: 16,
          borderRadius: SmoothBorderRadius(cornerRadius: 22),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.3,
              padding: const EdgeInsets.symmetric(vertical: 22),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: GlobalColors.borderColor, width: 2),
                borderRadius: SmoothBorderRadius(cornerRadius: 24),
              ),
              child: Column(
                children: [
                  const Text("🔥", style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 10),
                  Text(
                    "4 days",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "challenges done",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.battleshipGrey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.3,
              padding: const EdgeInsets.symmetric(vertical: 22),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: GlobalColors.borderColor, width: 2),
                borderRadius: SmoothBorderRadius(cornerRadius: 24),
              ),
              child: Column(
                children: [
                  const Text("📅", style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 10),
                  Text(
                    "4 days",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "remaining",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.battleshipGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleCalender()
      ],
    );
  }
}
