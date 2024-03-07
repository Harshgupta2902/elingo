import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

final _getFlashCardDataController = Get.put(GetFlashCardDataController());

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({Key? key}) : super(key: key);

  @override
  FlashCardScreenState createState() => FlashCardScreenState();
}

class FlashCardScreenState extends State<FlashCardScreen> {
  late PageController _pageController;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getFlashCardDataController.getFlashCardData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Flash Cards",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: _getFlashCardDataController.obx(
        (state) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tap To Flip",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: state?.words?.length ?? 0,
                    onPageChanged: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = state?.words?[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Container(
                            decoration: AppBoxDecoration.getBoxDecoration(
                              showShadow: true,
                              borderRadius: 20,
                              color: AppColors.scienceBlue,
                            ),
                            child: Center(
                              child: Text(
                                item?.word?.toUpperCase() ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          back: Container(
                            decoration: AppBoxDecoration.getBoxDecoration(
                              showShadow: true,
                              borderRadius: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item?.word?.toUpperCase() ?? '',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(),
                                ),
                                Text(
                                  item?.example ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(),
                                ),
                                Text(
                                  "SYN: ${item?.synonyms.toString() ?? ""}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "ANT: ${item?.antonyms.toString() ?? ""}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentPage >= 0
                    ? () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                child: const Text("Previous"),
              ),
              ElevatedButton(
                onPressed: currentPage < (_getFlashCardDataController.state?.words?.length ?? 0) - 1
                    ? () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
