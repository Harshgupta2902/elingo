import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/flash_cards/view/category_view.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/blur_screen.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

final _getFlashCardDataController = Get.put(GetFlashCardDataController());

class CustomFlashCards extends StatefulWidget {
  final String categoryName;
  final String dbName;

  const CustomFlashCards({
    Key? key,
    required this.categoryName,
    required this.dbName,
  }) : super(key: key);

  @override
  State<CustomFlashCards> createState() => _CustomFlashCardsState();
}

class _CustomFlashCardsState extends State<CustomFlashCards> with TickerProviderStateMixin {
  late PageController _pageController;
  int currentPage = 0;
  bool isBlurred = false;

  final flutterTts = FlutterTts();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getFlashCardDataController.getFlashCardData(categoryName: widget.categoryName);
    isBlurred = true;
    openDataBase();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _animation = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack, // Use different curves for different effects
      ),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  openDataBase() async {
    var liked = await Hive.openBox("LikedFlashCards");
    var saved = await Hive.openBox("SavedFlashCards");

    List<dynamic> likedItemList = liked.get("LikedFlashCards", defaultValue: []);
    _getFlashCardDataController.testLikedData.value = likedItemList;

    List<dynamic> savedItemList = saved.get("SavedFlashCards", defaultValue: []);
    _getFlashCardDataController.testSavedData.value = savedItemList;
  }

  Future<void> addAndDeleteDataTOHiveBox(Map<String, dynamic> boxData, {required String tableName}) async {
    var box = await Hive.openBox(tableName);

    var itemList = box.get(tableName, defaultValue: []);

    bool allReadyExist = itemList.any((element) => element["title"] == boxData["title"]);
    debugPrint("allReadyExist ----------- $allReadyExist");

    if (allReadyExist) {
      itemList.removeWhere((element) => element["title"] == boxData["title"]);

      await box.put(tableName, itemList);

      setState(() {});
      return;
    }

    if (!allReadyExist) {
      itemList.add(boxData);

      await box.put(tableName, itemList);

      setState(() {});
      return;
    }
  }

  bool isLikedItemExists(dynamic item) {
    return _getFlashCardDataController.testLikedData.any((element) => element["title"] == item["title"]);
  }

  bool isSavedItemExists(dynamic item) {
    return _getFlashCardDataController.testSavedData.any((element) => element["title"] == item["title"]);
  }

  Future _speak(String word) async {
    await flutterTts.speak(word);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.zircon,
          appBar: CustomAppBar(
            title: widget.dbName,
            isProfileView: false,
          ),
          body: _getFlashCardDataController.obx(
            (state) {
              return PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: state?.words?.length ?? 0,
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = state?.words?[index];

                  final boxData = {
                    "id": item?.id ?? '',
                    "title": item?.title ?? "",
                    "description": item?.exampleSentence ?? "",
                    "antonyms": item?.antonyms.toString() ?? "",
                    "synonyms": item?.synonyms.toString() ?? "",
                  };

                  final isLikedOrExists = isLikedItemExists(boxData);
                  final isSavedOrExists = isSavedItemExists(boxData);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: AppBoxDecoration.getBoxDecoration(
                      showShadow: false,
                      borderRadius: 8,
                      color: AppColors.zircon,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item?.title ?? '',
                                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                        color: AppColors.black,
                                      ),
                                ),
                                const SizedBox(height: 60),
                                Text(
                                  item?.exampleSentence ?? '',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const SizedBox(height: 40),
                                RichText(
                                  text: TextSpan(
                                    text: 'SYN: ',
                                    style: Theme.of(context).textTheme.titleSmall,
                                    children: List.generate(
                                      item?.synonyms?.length ?? 0,
                                      (index) {
                                        final itemData = item?.synonyms?[index];
                                        return TextSpan(
                                          text: " ${itemData ?? ""} ,",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    text: 'ANT: ',
                                    style: Theme.of(context).textTheme.titleSmall,
                                    children: List.generate(
                                      item?.antonyms?.length ?? 0,
                                      (index) {
                                        final itemData = item?.antonyms?[index];
                                        return TextSpan(
                                          text: " ${itemData ?? ""} ,",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Share.share(item?.title ?? "", subject: item?.title ?? "");
                                },
                                child: SvgPicture.asset(AssetPath.share, height: 30, width: 30),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _speak(item?.title ?? "");
                                },
                                child: SvgPicture.asset(AssetPath.speaker, height: 30, width: 30),
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     await addAndDeleteDataTOHiveBox(boxData, tableName: "LikedFlashCards");
                              //     openDataBase();
                              //     setState(() {});
                              //     return;
                              //   },
                              //   child: SvgPicture.asset(
                              //     isLikedOrExists ? AssetPath.heartFilled : AssetPath.heart,
                              //     height: 30,
                              //     width: 30,
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () async {
                                  await addAndDeleteDataTOHiveBox(boxData, tableName: "LikedFlashCards");
                                  openDataBase();
                                  setState(() {});
                                  _controller.forward(from: 0.0); // Start the animation from the beginning
                                  return;
                                },
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _animation.value,
                                      child: SvgPicture.asset(
                                        isLikedOrExists ? AssetPath.heartFilled : AssetPath.heart,
                                        height: 30,
                                        width: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await addAndDeleteDataTOHiveBox(boxData, tableName: "SavedFlashCards");
                                  openDataBase();
                                  setState(() {});
                                  return;
                                },
                                child: SvgPicture.asset(
                                  isSavedOrExists ? AssetPath.saved : AssetPath.save,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: getElevatedButtonStyle(
                    width: 90,
                    height: 40,
                    borderRadius: 20,
                    showShadow: true,
                    elevation: 2,
                    backgroundColor: AppColors.white,
                  ),
                  onPressed: () {
                    debugPrint("category button pressed");
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      showDragHandle: true,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                        minHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      builder: (context) {
                        return FlashCardCategoryView(
                          routesData: [
                            KeyValuePair(
                              key: "Liked Flash Cards",
                              value: "LikedFlashCards",
                              path: "likedFlashCardsView",
                            ),
                            KeyValuePair(
                              key: "Saved Flash Cards",
                              value: "SavedFlashCards",
                              path: "likedFlashCardsView",
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AssetPath.category,
                        height: 16,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Category",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.black,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        BlurWidget(
          isBlurred: isBlurred,
          assetPath: AssetPath.swipeUp,
          onTap: () {
            setState(() {
              isBlurred = !isBlurred;
            });
          },
          onVerticalDragUpdate: (p0) {
            debugPrint(" -------------------- onVerticalDragUpdate");
            setState(() {
              isBlurred = !isBlurred;
            });
          },
        ),
      ],
    );
  }
}
