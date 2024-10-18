import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

final _getFlashCardDataController = Get.put(GetFlashCardDataController());

class LikedFlashCardsView extends StatefulWidget {
  final String dbName;
  final String title;

  const LikedFlashCardsView({
    Key? key,
    required this.dbName,
    required this.title,
  }) : super(key: key);

  @override
  State<LikedFlashCardsView> createState() => _LikedFlashCardsViewState();
}

class _LikedFlashCardsViewState extends State<LikedFlashCardsView> {
  late PageController _pageController;
  List testLikedData = [];
  RxList testSavedData = [].obs;
  int currentPage = 1;
  List dataList = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    debugPrint(" here is the widget name ${widget.dbName}");
    openDataBase();
  }

  openDataBase() async {
    var box = await Hive.openBox(widget.dbName);

    setState(() {
      dataList = box.get(widget.dbName, defaultValue: []);
      debugPrint(" here is the list length $dataList");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        isProfileView: false,
        bgColor: AppColors.zircon,
      ),
      body: dataList.isEmpty == true
          ? const Center(child: Text("No data found"))
          : PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: dataList.length,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                debugPrint(dataList.length.toString());
                final item = dataList[index];
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: AppBoxDecoration.getBoxDecoration(
                    showShadow: false,
                    borderRadius: 8,
                    color: AppColors.zircon,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title'] ?? '',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        item['description'] ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(thickness: 1),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'SYN: ',
                          style: Theme.of(context).textTheme.titleLarge,
                          children: List.generate(
                            item['synonyms'].length ?? 0,
                            (index) {
                              final itemData = item['synonyms'][index];
                              return TextSpan(
                                text: itemData,
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            },
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'ANT: ',
                          style: Theme.of(context).textTheme.titleLarge,
                          children: List.generate(
                            item["antonyms"].length ?? 0,
                            (index) {
                              final itemData = item["antonyms"][index];
                              return TextSpan(
                                text: itemData,
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
