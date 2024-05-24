import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class ChooseMockTestScreen extends StatefulWidget {
  const ChooseMockTestScreen({Key? key}) : super(key: key);

  @override
  State<ChooseMockTestScreen> createState() => _ChooseMockTestScreenState();
}

class _ChooseMockTestScreenState extends State<ChooseMockTestScreen> {
  final dynamicQuizApiList = [
    "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
    "https://run.mocky.io/v3/f182d03e-562d-41d5-9894-a247307775b0",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/d303fe66-e401-446a-a0be-d2eeb6bcbaa0",
    "https://run.mocky.io/v3/0b47d609-8d14-4e09-95a5-17b30e0652dc",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
  ];

  late List<int> testStates = List.generate(dynamicQuizApiList.length, (index) => 0);

  RxInt completedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    // Initialize test states based on user's progress
    testStates = List.generate(dynamicQuizApiList.length, (index) {
      // Mock logic: Unlock the first test, lock the rest initially
      if (index == 0) {
        return 1; // 1 represents unlocked, 0 represents locked
      } else {
        // Check if the previous test is completed
        final previousTestState = testStates[index - 1];
        return previousTestState == 2 ? 1 : 0; // 2 represents completed
      }
    });
  }

  void updateTestState(int index) {
    setState(() {
      // Update the state of the completed test
      testStates[index] = 2; // Mark as completed
      // If there are more tests after the completed one, unlock them
      if (index + 1 < testStates.length) {
        testStates[index + 1] = 1; // Unlock the next one
      }
    });
  }

  void completeAndOpenNextTest(int index) {
    // Mark the current test as completed
    updateTestState(index);

    // Open the next test if available
    if (index + 1 < dynamicQuizApiList.length) {
      context.push(
        GoPaths.dailyQuizScreen,
        extra: {
          "apiUrl": dynamicQuizApiList[index + 1],
          "CompletedIndex": index + 1,
          "onTestCompleted": updateTestState, // Pass the function
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Choose Mock Test",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // My Course Progress
            // ...

            const SizedBox(height: 10),
            // Grid View for mock tests
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisExtent: 180, // Adjust height as needed
                mainAxisSpacing: 20,
              ),
              itemCount: dynamicQuizApiList.length,
              itemBuilder: (context, index) {
                final apiUrl = dynamicQuizApiList[index];
                final testState = testStates[index];

                return GestureDetector(
                  onTap: () {

                    completeAndOpenNextTest(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: AppBoxDecoration.getBorderBoxDecoration(
                      showShadow: true,
                      shadowColor: AppColors.brightGrey.withOpacity(0.05),
                      color: AppColors.white,
                      borderRadius: 16,
                      blurRadius: 6,
                      borderColor: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Mock Test ${index + 1}",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.brightGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            testState == 2
                                ? "Completed"
                                : testState == 1
                                ? "Practice Makes a Man Perfect!"
                                : "Unlock by completing previous test",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.brightGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          testState == 2
                              ? const Icon(Icons.done, size: 40, color: AppColors.brightGrey)
                              : testState == 1
                              ? Image.asset(
                            AssetPath.image,
                            height: 65,
                            width: 65,
                          )
                              : const Icon(Icons.lock, size: 40, color: AppColors.brightGrey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
