import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class StartLessonScreen extends StatefulWidget {
  const StartLessonScreen({super.key});

  @override
  State<StartLessonScreen> createState() => _StartLessonScreenState();
}

class _StartLessonScreenState extends State<StartLessonScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          MyNavigator.pushReplacementNamed(GoPaths.questionsView);
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VocabularyAppBar(
        leadingWidget: IconButton(
          splashRadius: 1,
          splashColor: Colors.transparent,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              MyNavigator.pop();
            }
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                GlobalImages.smile,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(height: 40),
              Text(
                "Loading ...",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: GlobalColors.primaryColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _animation.value,
                minHeight: 12,
                color: GlobalColors.primaryColor,
                backgroundColor: GlobalColors.borderColor,
                borderRadius: SmoothBorderRadius(cornerRadius: 16),
              ),
              const SizedBox(height: 40),
              Text(
                "Complete the course faster to get more XP and Diamonds",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.battleshipGrey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
