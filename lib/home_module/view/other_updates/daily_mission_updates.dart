// import 'package:flutter/material.dart';
// import 'package:vocablury/global.dart';
// import 'package:vocablury/utilities/navigation/go_paths.dart';
// import 'package:vocablury/utilities/navigation/navigator.dart';
//
// import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
//
// class DailyMissionUpdates extends StatefulWidget {
//   const DailyMissionUpdates({super.key});
//
//   @override
//   State<DailyMissionUpdates> createState() => _DailyMissionUpdatesState();
// }
//
// class _DailyMissionUpdatesState extends State<DailyMissionUpdates> {
//   static const missionUpdates = [
//     {'image': '🔷', 'name': 'Get 25 Diamonds', 'total': '25', 'achieved': '12'},
//     {'image': '⚡', 'name': 'Get 40 XP', 'total': '40', 'achieved': '24'},
//     {'image': '🎯', 'name': 'Get 2 perfect lessons', 'total': '2', 'achieved': '0'},
//     {'image': '🔥', 'name': 'Complete 1 Challenge', 'total': '1', 'achieved': '1'},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const SizedBox(height: kToolbarHeight),
//               Text(
//                 "Daily Mission Updates!",
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: GlobalColors.primaryColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                     ),
//               ),
//               Flexible(
//                 child: ListView.separated(
//                   padding: const EdgeInsets.only(top: 30),
//                   itemCount: missionUpdates.length,
//                   itemBuilder: (context, index) {
//                     double? total =
//                         double.tryParse(missionUpdates[index]['total']?.toString() ?? '');
//                     double? achieved =
//                         double.tryParse(missionUpdates[index]['achieved']?.toString() ?? '');
//
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding: const EdgeInsets.all(16),
//                       decoration: ShapeDecoration(
//                         shape: SmoothRectangleBorder(
//                           borderRadius: SmoothBorderRadius(cornerRadius: 16),
//                           side: const BorderSide(color: GlobalColors.borderColor, width: 2),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             missionUpdates[index]['image']!,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineLarge
//                                 ?.copyWith(color: Colors.black),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(missionUpdates[index]['name']!,
//                                     style: Theme.of(context).textTheme.bodyLarge),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width * 0.5,
//                                       child: LinearProgressIndicator(
//                                         color: GlobalColors.primaryColor,
//                                         backgroundColor: GlobalColors.borderColor,
//                                         value: achieved! / total!,
//                                         minHeight: 8,
//                                         borderRadius: SmoothBorderRadius(cornerRadius: 16),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       "${achieved.toInt()} / ${total.toInt()}",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleSmall
//                                           ?.copyWith(color: GlobalColors.primaryColor),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const SizedBox(height: 26);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             top: BorderSide(
//               color: GlobalColors.borderColor,
//             ),
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: ElevatedButton(
//           onPressed: () {
//             MyNavigator.pushNamed(GoPaths.onBoardingQuestions);
//           },
//           child: const Text("CONTINUE"),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class DailyMissionUpdates extends StatefulWidget {
  const DailyMissionUpdates({super.key});

  @override
  State<DailyMissionUpdates> createState() => _DailyMissionUpdatesState();
}

class _DailyMissionUpdatesState extends State<DailyMissionUpdates> with TickerProviderStateMixin {
  static const missionUpdates = [
    {'image': '🔷', 'name': 'Get 25 Diamonds', 'total': '25', 'achieved': '12'},
    {'image': '⚡', 'name': 'Get 40 XP', 'total': '40', 'achieved': '24'},
    {'image': '🎯', 'name': 'Get 2 perfect lessons', 'total': '2', 'achieved': '0'},
    {'image': '🔥', 'name': 'Complete 1 Challenge', 'total': '1', 'achieved': '1'},
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  int _currentAnimationIndex = 0;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(missionUpdates.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );
    });

    _animations = List.generate(missionUpdates.length, (index) {
      double? total = double.tryParse(missionUpdates[index]['total']?.toString() ?? '');
      double? achieved = double.tryParse(missionUpdates[index]['achieved']?.toString() ?? '');
      return Tween<double>(begin: 0, end: achieved! / total!).animate(_controllers[index])
        ..addListener(() {
          setState(() {});
        });
    });

    _startNextAnimation();
  }

  void _startNextAnimation() {
    if (_currentAnimationIndex < _controllers.length) {
      double? achieved =
          double.tryParse(missionUpdates[_currentAnimationIndex]['achieved']?.toString() ?? '');
      if (achieved == 0) {
        _currentAnimationIndex++;
        Future.delayed(const Duration(milliseconds: 500), _startNextAnimation);
      } else {
        _controllers[_currentAnimationIndex].forward().whenComplete(() {
          _currentAnimationIndex++;
          Future.delayed(const Duration(milliseconds: 500), _startNextAnimation);
        });
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: kToolbarHeight),
            Text(
              "Daily Mission Updates!",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: GlobalColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
            ),
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 30),
                itemCount: missionUpdates.length,
                itemBuilder: (context, index) {
                  double? total = double.tryParse(missionUpdates[index]['total']?.toString() ?? '');
                  double? achieved =
                      double.tryParse(missionUpdates[index]['achieved']?.toString() ?? '');

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(cornerRadius: 16),
                        side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          missionUpdates[index]['image']!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                missionUpdates[index]['name']!,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: LinearProgressIndicator(
                                      color: GlobalColors.primaryColor,
                                      backgroundColor: GlobalColors.borderColor,
                                      value: _animations[index].value,
                                      minHeight: 8,
                                      borderRadius: SmoothBorderRadius(cornerRadius: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${(achieved!.toInt())} / ${total!.toInt()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: GlobalColors.primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 26);
                },
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            MyNavigator.pushNamed(GoPaths.dailyStreak);
          },
          child: const Text("CONTINUE"),
        ),
      ),
    );
  }
}
