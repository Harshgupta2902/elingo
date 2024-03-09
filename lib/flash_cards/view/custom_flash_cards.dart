import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/flash_cards/view/category_view.dart';
import 'package:vocablury/sqflite_database/db_connection/database_helper.dart';
import 'package:vocablury/sqflite_database/model/liked_flash_cards_model.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/blur_screen.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

final _getFlashCardDataController = Get.put(GetFlashCardDataController());

final dbReturnData = DatabaseHelper.getAllData();

class CustomFlashCards extends StatefulWidget {
  final String categoryName;

  const CustomFlashCards({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CustomFlashCards> createState() => _CustomFlashCardsState();
}

class _CustomFlashCardsState extends State<CustomFlashCards> {
  late PageController _pageController;
  int currentPage = 0;
  bool isBlurred = false;
  final player = AudioPlayer();
  final flutterTts = FlutterTts();

  List? likedData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getFlashCardDataController.getFlashCardData(
      widget.categoryName,
    );
    isBlurred = true;
    debugPrint("initState ${_getFlashCardDataController.likedCardList.length}");
    fetchData();
  }

  Future _speak(String word) async {}

  Future<void> fetchData() async {
    List? fetchedData = await DatabaseHelper.getAllData();
    setState(() {
      likedData = fetchedData?.map((e) => e.toJson()).toList();
    });
  }

  bool isItemExists(LikedFlashCardsModel? item) {
    return likedData?.any((element) => element["title"] == item?.title) ?? false;
  }

  void updateLikedCardList(Map data) {
    _getFlashCardDataController.likedCardList.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.zircon,
          appBar: const CustomAppBar(
            title: "Flash Cards",
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
                                  item?.word ?? '',
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
                                  Share.share(
                                    item?.word ?? "",
                                    subject: "  ${item?.word ?? ""}",
                                  );
                                },
                                child: SvgPicture.asset(
                                  AssetPath.share,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _speak(item?.word ?? "");
                                },
                                child: SvgPicture.asset(
                                  AssetPath.speaker,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final LikedFlashCardsModel data = LikedFlashCardsModel(
                                    id: item?.id?.toInt() ?? 0,
                                    title: item?.word ?? "",
                                    description: item?.exampleSentence ?? "",
                                    antonyms: item?.antonyms.toString() ?? "",
                                    synonyms: item?.synonyms.toString() ?? "",
                                  );

                                  if (isItemExists(
                                    LikedFlashCardsModel(
                                      id: item?.id?.toInt() ?? 0,
                                      title: item?.word ?? "",
                                      description: item?.exampleSentence ?? "",
                                      antonyms: item?.antonyms.toString() ?? "",
                                      synonyms: item?.synonyms.toString() ?? "",
                                    ),
                                  )) {
                                    await DatabaseHelper.deleteNote(data).then((value) {
                                      fetchData();
                                    });
                                    debugPrint("here is the Data ");
                                    return;
                                  }

                                  await DatabaseHelper.addNote(data).then((value) {
                                    fetchData();
                                  });
                                },
                                child: SvgPicture.asset(
                                  isItemExists(
                                    LikedFlashCardsModel(
                                      id: item?.id?.toInt() ?? 0,
                                      title: item?.word ?? "",
                                      description: item?.exampleSentence ?? "",
                                      antonyms: item?.antonyms.toString() ?? "",
                                      synonyms: item?.synonyms.toString() ?? "",
                                    ),
                                  )
                                      ? AssetPath.heartFilled
                                      : AssetPath.heart,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SvgPicture.asset(
                                isItemExists(
                                  LikedFlashCardsModel(
                                    id: item?.id?.toInt() ?? 0,
                                    title: item?.word ?? "",
                                    description: item?.exampleSentence ?? "",
                                    antonyms: item?.antonyms.toString() ?? "",
                                    synonyms: item?.synonyms.toString() ?? "",
                                  ),
                                ) ?
                                AssetPath.saved : AssetPath.save,
                                height: 30,
                                width: 30,
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
                    showCustomBottomSheet(context);
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
                const Text("data"),
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

void showCustomBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    showDragHandle: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      minHeight: MediaQuery.of(context).size.height * 0.5,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return FlashCardCategoryView();
    },
  );
}
