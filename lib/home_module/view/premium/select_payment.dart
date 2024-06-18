import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/leaderboard/all_time.dart';
import 'package:vocablury/home_module/view/leaderboard/monthly.dart';
import 'package:vocablury/home_module/view/leaderboard/weekly.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({super.key});

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  static const paymentMethods = [
    {
      'image': 'https://cdn.pixabay.com/photo/2018/05/08/21/29/paypal-3384015_1280.png',
      'name': 'PayPal',
      'radioId': 'paypal',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRon0edsTcidGmV0UoWcBzLUtJB7nTrVMsf0Wi8thVMJ-dQONH_c30m6Mbj5PKJUkpLBoI&usqp=CAU',
      'name': 'Google Pay',
      'radioId': 'gpay',
    },
    {
      'image':
          'https://static.vecteezy.com/system/resources/previews/019/766/198/large_2x/apple-logo-apple-icon-transparent-free-png.png',
      'name': 'Apple Pay',
      'radioId': 'apay',
    },
    {
      'image': 'https://i.pinimg.com/736x/56/fd/48/56fd486a48ff235156b8773c238f8da9.jpg',
      'name': '.... .... .... 5252',
      'radioId': 'card1',
    },
  ];
  int _selectedRadioIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      appBar: VocabularyAppBar(
        appBgColor: Colors.transparent,
        title: "Premium",
        leadingColor: Colors.white,
        leadingWidget: IconButton(
          onPressed: () {
            MyNavigator.goNamed(GoPaths.dashboardLevels);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 22),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Select payment method",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: GlobalColors.borderColor, thickness: 1),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: paymentMethods.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final paymentMethod = paymentMethods[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRadioIndex = index;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: _selectedRadioIndex == index
                                ? GlobalColors.secondaryButtonColor
                                : null,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(cornerRadius: 16),
                              side: BorderSide(
                                  color: _selectedRadioIndex == index
                                      ? GlobalColors.primaryColor
                                      : GlobalColors.borderColor,
                                  width: 2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 52,
                                    height: 52,
                                    child: Image.network(
                                      paymentMethod['image']!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    paymentMethod['name']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Radio(
                                value: index,
                                groupValue: _selectedRadioIndex,
                                fillColor:
                                    const MaterialStatePropertyAll(GlobalColors.primaryColor),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRadioIndex = value as int;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: GlobalColors.borderColor, thickness: 1),
                  ),
                  Text(
                    "Enter coupon code",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, color: GlobalColors.primaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: GlobalColors.borderColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ElevatedButton(
          onPressed: () {
            MyNavigator.pushNamed(GoPaths.paymentSuccess);
          },
          child: const Text("Confirm Payment"),
        ),
      ),
    );
  }
}
