import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/leaderboard/leader_levels.dart';

class MonthlyLeaderBoard extends StatelessWidget {
  const MonthlyLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const LeaderLevelsWidget(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100, top: 20),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://toppng.com/uploads/preview/badge-silver-transparent-image-11602399622zcfw25lckh.png",
                      height: 20,
                      width: 20,
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
        ],
      ),
    );
  }
}
