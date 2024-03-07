import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/components/custom_container.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

class ChooseFlashCardScreen extends StatefulWidget {
  const ChooseFlashCardScreen({Key? key}) : super(key: key);

  @override
  State<ChooseFlashCardScreen> createState() => _ChooseFlashCardScreenState();
}

class _ChooseFlashCardScreenState extends State<ChooseFlashCardScreen> {
  final dynamicQuizApiList = [
    {
      "url": "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
      "title": "Mock Test 1",
      "description": "This is the first mock test.",
      "image": "assets/png_images/image.png",
    },
    {
      "url": "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
      "title": "Mock Test 2",
      "description": "This is the second mock test.",
      "image": "assets/png_images/flash.png"
    },
    {
      "url": "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
      "title": "Mock Test 4",
      "description": "This is the fourth mock test.",
      "image": "assets/png_images/music.png"
    },
    {
      "url": "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
      "title": "Mock Test 4",
      "description": "This is the fourth mock test.",
      "image": "assets/png_images/music.png"
    },
    {
      "url": "https://run.mocky.io/v3/d303fe66-e401-446a-a0be-d2eeb6bcbaa0",
      "title": "Mock Test 5",
      "description": "This is the fifth mock test.",
      "image": "assets/png_images/image.png"
    },
    {
      "url": "https://run.mocky.io/v3/0b47d609-8d14-4e09-95a5-17b30e0652dc",
      "title": "Mock Test 6",
      "description": "This is the sixth mock test.",
      "image": "assets/png_images/flash.png"
    },
    {
      "url": "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
      "title": "Mock Test 7",
      "description": "This is the seventh mock test.",
      "image": "assets/png_images/music.png"
    },
    {
      "url": "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
      "title": "Mock Test 8",
      "description": "This is the eighth mock test.",
      "image": "assets/png_images/flash.png"
    },
    {
      "url": "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
      "title": "Mock Test 9",
      "description": "This is the ninth mock test.",
      "image": "assets/png_images/image.png"
    },
    {
      "url": "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
      "title": "Mock Test 10",
      "description": "This is the tenth mock test.",
      "image": "assets/png_images/music.png"
    }
  ];

  int selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Flash Cards",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {},
      ),
      body: Stack(
        children: [
          CustomContainer(
            cardData: List.generate(10, (index) {
              return KeyValuePair(
                key: "Mock Test ${index + 1}",
                value: "This is the ${index + 1} mock test.",
                path: AssetPath.image,
              );
            }),
            onTap: (index) {
              setState(() {
                selectedItem = index;
              });
            },
          ),
          if (selectedItem != -1)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = -1;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.brightGrey.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dynamicQuizApiList[selectedItem]['title']!,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.brightGrey,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                dynamicQuizApiList[selectedItem]['description']!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.brightGrey,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                dynamicQuizApiList[selectedItem]['image']!,
                                height: 65,
                                width: 65,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                                child: OutlinedButton(
                                  style: getOutlinedButtonStyle(
                                    borderRadius: 12,
                                    borderColor: AppColors.scienceBlue,
                                    borderWidth: 2.0,
                                    buttonColor: Colors.transparent,
                                    height: 50,
                                    width: 150,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedItem = -1;
                                    });
                                    context.push(GoPaths.customFlashCards);
                                  },
                                  child: Text(
                                    'View Flash Card',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.scienceBlue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
