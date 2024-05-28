import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: kToolbarHeight),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetPath.dialogDown),
                    fit: BoxFit.fill,
                  ),
                ),
                padding: const EdgeInsets.only(left: 26, right: 26, top: 10, bottom: 16),
                child: const Text("Hi there! I'm El!"),
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(
              GlobalImages.smile,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(height: 40),
            Text(
              GlobalText.appName,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: GlobalColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(
              "Learn Languages whenever and wherever you want. It's free and forever",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.battleshipGrey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
              onPressed: () {},
              child: const Text("GET STARTED"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.secondaryButtonColor,
                foregroundColor: GlobalColors.primaryColor,
              ),
              onPressed: () {},
              child: const Text("I ALREADY HAVE AN ACCOUNT"),
            ),
          ],
        ),
      ),
    );
  }
}
