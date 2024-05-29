import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
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
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 16),
                child: Text(
                  "Hurray!",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(
              GlobalImages.smile,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(height: 40),
            Text(
              "Welcome back!",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: GlobalColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(
              "You have successfully reset and create your password",
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
              onPressed: () {
                MyNavigator.popUntilAndPushNamed(GoPaths.login);
              },
              child: const Text("Continue to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
