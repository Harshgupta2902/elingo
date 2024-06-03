import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';

class OnboardingQuestionsScreen extends StatefulWidget {
  const OnboardingQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingQuestionsScreen> createState() => _OnboardingQuestionsScreenState();
}

class _OnboardingQuestionsScreenState extends State<OnboardingQuestionsScreen> {
  int activeIndex = 0;
  int currentPageIndex = 0;
  PageController controller = PageController();
  double progressValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final questions = [
      "I just started learning",
      "I know some words and phrases",
      "I can have a simple conversation",
      "I am at an intermediate level"
    ];
    progressValue = (currentPageIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => MyNavigator.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: LinearProgressIndicator(
          color: GlobalColors.primaryColor,
          value: progressValue,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          minHeight: 8,
          backgroundColor: GlobalColors.borderColor,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(GlobalImages.smile),
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetPath.dialogLeft),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 16),
                        child: Text(
                          "Why are you studying English?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: GlobalColors.borderColor, thickness: 1),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Flexible(
            child: PageView.builder(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) async {
                setState(() {
                  currentPageIndex = value;
                });
              },
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListView.separated(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: AppBoxDecoration.getBorderBoxDecoration(
                          showShadow: false,
                          borderColor: activeIndex == index
                              ? GlobalColors.primaryColor
                              : GlobalColors.borderColor,
                          color: activeIndex == index
                              ? GlobalColors.secondaryButtonColor
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.signal_cellular_alt_outlined,
                              color: GlobalColors.primaryColor,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                questions[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                );
              },
            ),
          ),
        ],
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
        child: ElevatedButton(
          onPressed: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 600),
              curve: Curves.linear,
            );
            if (currentPageIndex + 1 == questions.length) {
              MyNavigator.popUntilAndPushNamed(GoPaths.onboardingSuccessScreen);
            }
          },
          child: const Text("CONTINUE"),
        ),
      ),
    );
  }
}
