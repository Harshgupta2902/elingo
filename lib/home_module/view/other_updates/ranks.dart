import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/animated_checkboxes.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_box_decoration.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class AllRanks extends StatelessWidget {
  const AllRanks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight),
                const Text("🔥", style: TextStyle(fontSize: 100)),
                const SizedBox(height: 12),
                Text(
                  "Cool! you rank goes up!",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                ),
                const SizedBox(height: 26),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: SmoothBorderRadius(cornerRadius: 26),
                    border: Border.all(color: GlobalColors.borderColor, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://toppng.com/uploads/preview/badge-silver-transparent-image-11602399622zcfw25lckh.png",
                            height: 20,
                          ),
                          const SizedBox(width: 20),
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://node.onlineinfotech.net/_next/image?url=%2FAMC%2Fimage_4.png&w=96&q=75",
                              height: 42,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Maryland Verna",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const Spacer(),
                          Text(
                            "768 XP",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: GlobalColors.borderColor, thickness: 1),
                      );
                    },
                    itemCount: 8,
                  ),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ElevatedButton(
          onPressed: () => MyNavigator.goNamed(GoPaths.leaderBoard),
          child: const Text("OK Great!"),
        ),
      ),
    );
  }
}
