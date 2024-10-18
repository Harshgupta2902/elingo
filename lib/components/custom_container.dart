import 'package:flutter/material.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

typedef GridCallBack = void Function(int);

class CustomContainer extends StatefulWidget {
  final List cardData;
  final GridCallBack onTap;

  const CustomContainer({
    super.key,
    required this.cardData,
    required this.onTap,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisExtent: 200,
        mainAxisSpacing: 20,
      ),
      itemCount: widget.cardData.length ?? 0,
      itemBuilder: (context, index) {
        final item = widget.cardData[index];

        return GestureDetector(
          onTap: () {
            widget.onTap(index);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: AppBoxDecoration.getBorderBoxDecoration(
              showShadow: true,
              shadowColor: AppColors.brightGrey.withOpacity(0.05),
              color: AppColors.white,
              borderRadius: 16,
              borderColor: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        item.key,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.brightGrey,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.value,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.brightGrey,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Image.asset(
                      item.path,
                      height: 65,
                      width: 65,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
