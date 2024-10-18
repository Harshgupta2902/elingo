import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

Widget customTestListBuilder({
  required List items,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 25,
    ),
    shrinkWrap: true,
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        title: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              SvgPicture.asset(
                AssetPath.worldIcon, // Path to your SVG file
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 15),
              Text(
                items[index],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget loadAssetImage(String imagePath) {
  if (imagePath.endsWith('.png')) {
    return Image.asset(
      imagePath,
      fit: BoxFit.fill,
    );
  }

  if (imagePath.endsWith('.svg')) {
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.fill,
    );
  }

  return Image.asset(
    imagePath,
    fit: BoxFit.fill,
  );
}

Widget buildGridContainers({
  required BuildContext context,
  required List<String> svgPaths,
  List<String>? svgData, // Add nullable type for svgData
  List<String>? routesData, // Add nullable type for routesData
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 10),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 12,
        mainAxisSpacing: 18,
        crossAxisCount: 3,
        mainAxisExtent: 100,
      ),
      itemCount: svgPaths.length,
      itemBuilder: (BuildContext context, int index) {
        final svgPath = svgPaths[index];
        final itemName = svgData?[index] ?? '';
        final routeName = routesData?[index] ?? '';

        return GestureDetector(
          onTap: () {
            context.push("/$routeName");
          },
          child: Container(
            decoration: AppBoxDecoration.getBoxDecoration(
              showShadow: true,
              blurRadius: 15,
              color: Colors.white,
              borderRadius: 11,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: loadAssetImage(svgPath),
                ),
                const SizedBox(height: 12),
                Text(
                  itemName,
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}


Widget buildScrollContainers({
  required BuildContext context,
  String? description,
  String? userName,
  String? userImg,
  String? userPost,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    decoration: AppBoxDecoration.getBorderBoxDecoration(
      color: AppColors.white,
      borderRadius: 18,
      showShadow: true,
      borderColor: Colors.transparent,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Text(
            description ?? "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.brightGrey,
                ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                userImg ?? "",
                height: 55,
                width: 55,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userPost ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
