import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class LessonComplete extends StatefulWidget {
  const LessonComplete({super.key});

  @override
  State<LessonComplete> createState() => _LessonCompleteState();
}

class _LessonCompleteState extends State<LessonComplete> with TickerProviderStateMixin {
  late AnimationController _xpController;
  late Animation<int> _timeAnimation;
  late AnimationController _timeController;
  late Animation<int> _xpAnimation;
  late AnimationController _diamondController;
  late Animation<int> _diamondAnimation;
  late AnimationController _accuracyController;
  late Animation<int> _accuracyAnimation;

  int xpTargetNumber = 40;
  int receivedDiamonds = 16;
  int accuracy = 85;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // XP Animation
      _xpController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );

      _xpAnimation = IntTween(begin: 0, end: xpTargetNumber).animate(_xpController)
        ..addListener(() {
          setState(() {});
        });

      _xpController.forward();

      // Diamond Animation
      _diamondController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );

      _diamondAnimation = IntTween(begin: 0, end: receivedDiamonds).animate(_diamondController)
        ..addListener(() {
          setState(() {});
        });

      _diamondController.forward();

      // Accuracy Animation
      _accuracyController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );

      _accuracyAnimation = IntTween(begin: 0, end: accuracy).animate(_accuracyController)
        ..addListener(() {
          setState(() {});
        });

      _accuracyController.forward();

      // Time Animation
      _timeController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );

      _timeAnimation = IntTween(begin: 0, end: timeStringToSeconds("1:45")).animate(_timeController)
        ..addListener(() {
          setState(() {});
        });

      _timeController.forward();
    });
  }

  @override
  void dispose() {
    _timeController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  int timeStringToSeconds(String timeString) {
    List<String> timeParts = timeString.split(':');
    int minutes = int.parse(timeParts[0]);
    int seconds = int.parse(timeParts[1]);

    return (minutes * 60) + seconds;
  }

  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String secs = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$secs';
  }

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
            Text(
              "Lesson Completed!",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: GlobalColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(
              GlobalImages.smile,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(height: 40),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: AppBoxDecoration.getBorderBoxDecoration(
                borderColor: AppColors.clearBlue,
                showShadow: false,
                borderRadius: 16,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.clearBlue,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        "Diamonds",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "🔷 ${_diamondAnimation.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    borderColor: AppColors.sunShade,
                    showShadow: false,
                    borderRadius: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.sunShade,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Total XP",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          // "🔷 12",
                          "🔷 ${_xpAnimation.value}",

                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    borderColor: AppColors.mediumAquaMarine,
                    showShadow: false,
                    borderRadius: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.mediumAquaMarine,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Time",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "⏲ ${formatDuration(_timeAnimation.value)}",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    borderColor: AppColors.brinkPink,
                    showShadow: false,
                    borderRadius: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.brinkPink,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Accuracy",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "🎯 ${_accuracyAnimation.value}%",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            MyNavigator.pushNamed(GoPaths.dailyMissionUpdates);
          },
          child: const Text("CONTINUE"),
        ),
      ),
    );
  }
}
