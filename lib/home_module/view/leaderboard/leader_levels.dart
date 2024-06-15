import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vocablury/global.dart'; // Adjust as per your project structure
import 'package:vocablury/utilities/constants/assets_path.dart'; // Adjust as per your project structure

class LeaderLevelsWidget extends StatelessWidget {
  const LeaderLevelsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const image =
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLeaderLevel(
            context,
            image: image,
            name: "Andrew",
            xp: 872,
            assetPath: AssetPath.leader2,
          ),
          _buildLeaderLevel(
            context,
            image: image,
            name: "MaryLand",
            xp: 948,
            assetPath: AssetPath.leader1,
          ),
          _buildLeaderLevel(
            context,
            image: image,
            name: "Charlotte",
            xp: 769,
            assetPath: AssetPath.leader3,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderLevel(
    BuildContext context, {
    required String image,
    required String name,
    required int xp,
    required String assetPath,
  }) {
    double containerHeight = 170;

    switch (assetPath) {
      case AssetPath.leader1:
        containerHeight = 200;
        break;
      case AssetPath.leader3:
        containerHeight = 140;
        break;
      default:
        containerHeight = 170;
        break;
    }
    return Flexible(
      child: Column(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 42,
              width: 42,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              '$xp XP',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: GlobalColors.primaryColor),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(assetPath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
