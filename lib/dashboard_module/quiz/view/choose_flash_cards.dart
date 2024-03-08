import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/components/custom_container.dart';
import 'package:vocablury/flash_cards/controller%20/get_flash_card_controller.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

final _getFlashCardController = Get.put(GetFlashCardListDataController());

class ChooseFlashCardScreen extends StatefulWidget {
  const ChooseFlashCardScreen({Key? key}) : super(key: key);

  @override
  State<ChooseFlashCardScreen> createState() => _ChooseFlashCardScreenState();
}

class _ChooseFlashCardScreenState extends State<ChooseFlashCardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFlashCardController.getFlashCardListData();
  }

  int selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: const CustomAppBar(
        title: "Flash Cards",
        isProfileView: false,
        bgColor: AppColors.zircon,
      ),
      body: _getFlashCardController.obx(
        (state) {
          return CustomContainer(
            cardData: List.generate(
              state?.categoryNameList?.length ?? 0,
              (index) {
                final item = state?.categoryNameList?[index];
                return KeyValuePair(
                  key: item?.title ?? "",
                  value: item?.subTitle ?? "",
                  path: AssetPath.image,
                );
              },
            ),
            onTap: (index) {
              final categoryNameList = state?.categoryNameList?[index];

              context.push(
                GoPaths.customFlashCards,
                extra: {
                  "categoryName": categoryNameList?.categoryName ?? "",
                },
              );
            },
          );
        },
      ),
    );
  }
}
