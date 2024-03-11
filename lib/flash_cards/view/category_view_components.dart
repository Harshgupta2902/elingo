import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/sqflite_database/db_connection/database_helper.dart';
import 'package:vocablury/sqflite_database/model/liked_flash_cards_model.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

final _getFlashCardDataController = Get.put(GetFlashCardDataController());

class LikedFlashCardsView extends StatefulWidget {
  const LikedFlashCardsView({Key? key}) : super(key: key);

  @override
  State<LikedFlashCardsView> createState() => _LikedFlashCardsViewState();
}

class _LikedFlashCardsViewState extends State<LikedFlashCardsView> {
  late PageController _pageController;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<LikedFlashCardsModel>? data = await DatabaseHelper.getLikedFlashCardsData();

    _getFlashCardDataController.flashCards.value = data?.toList() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Liked Flash Cards",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {},
      ),
      body: _getFlashCardDataController.obx(
        (state) {
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _getFlashCardDataController.flashCards.length,
            onPageChanged: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _getFlashCardDataController.flashCards[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to delete this note?'),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              _getFlashCardDataController.deleteLikedFlashCardFromController(item);
                              // await DatabaseHelper.deleteNote("LikedFlashCards", item);

                              await _fetchData();
                              setState(() {});
                              context.pop();
                            },
                            child: const Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
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
                          item.title ?? '',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: AppColors.black,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item.description ?? '',
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
                              item.synonyms.length ?? 0,
                              (index) {
                                final itemData = item.synonyms[index];
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
                              item.antonyms.length ?? 0,
                              (index) {
                                final itemData = item.antonyms[index];
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
                  ),
                ),
              );
            },
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (error) {
          return Text(error.toString());
        },
        onEmpty: const Center(
          child: Text("No data found"),
        ),
      ),
    );
  }
}
