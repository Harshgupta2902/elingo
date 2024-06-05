import 'package:flutter/material.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key, required this.selectedPaymentMethod});
  final Map<String, String> selectedPaymentMethod;
  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VocabularyAppBar(
        title: "Review Summary",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: GlobalColors.borderColor.withOpacity(0.5),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                  side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Diamonds",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.battleshipGrey),
                      ),
                      Text(
                        "2,000",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.battleshipGrey),
                      ),
                      Text(
                        "\$4.00",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.battleshipGrey),
                      ),
                      Text(
                        "\$0",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    height: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.battleshipGrey),
                      ),
                      Text(
                        "\$4.00",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: GlobalColors.primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "Payment Method",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 16),
                  side: const BorderSide(color: GlobalColors.borderColor, width: 2),
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
                          widget.selectedPaymentMethod['image'].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.selectedPaymentMethod['name'].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => MyNavigator.pop(),
                    child: Text(
                      "Change",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600, color: GlobalColors.primaryColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
