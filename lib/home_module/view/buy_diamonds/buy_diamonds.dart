import 'package:flutter/material.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class BuyDiamonds extends StatelessWidget {
  const BuyDiamonds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VocabularyAppBar(
        leadingWidget: IconButton(
          splashRadius: 1,
          splashColor: Colors.transparent,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              MyNavigator.pop();
            }
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                  side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🔷", style: TextStyle(fontSize: 54)),
                  const SizedBox(width: 22),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "You have",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: " 957 ",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: GlobalColors.diamondTextColor),
                              ),
                              TextSpan(
                                text: "diamonds.",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "You can use diamonds to freeze & increase the time to comlete the challenge",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.battleshipGrey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text(
              "Buy More Diamonds",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuyMoreCards(diamonds: 1000, price: "2.00"),
                BuyMoreCards(diamonds: 2000, price: "4.00"),
                BuyMoreCards(diamonds: 3000, price: "6.00"),
              ],
            ),
            const SizedBox(height: 26),
            Text(
              "Buy More Diamonds",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                  side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🟨", style: TextStyle(fontSize: 54)),
                  const SizedBox(width: 22),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Redeem Promo Code",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Enter promo code to get free diamonds.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.battleshipGrey),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Redeem Now",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: GlobalColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyMoreCards extends StatelessWidget {
  const BuyMoreCards({super.key, required this.price, required this.diamonds});

  final String price;
  final num diamonds;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => MyNavigator.pushNamed(GoPaths.selectPaymentMethod),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(cornerRadius: 16),
              side: const BorderSide(color: GlobalColors.borderColor, width: 2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("🔷", style: TextStyle(fontSize: 54)),
              const SizedBox(height: 22),
              Text("$diamonds",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text("\$ $price",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.battleshipGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
