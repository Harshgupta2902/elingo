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
      height: 40,
      width: 40,
    );
  }

  if (imagePath.endsWith('.svg')) {
    return SvgPicture.asset(
      imagePath,
      height: 40,
      width: 40,
    );
  }

  return Image.asset(
    imagePath,
    height: 40,
    width: 40,
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
        crossAxisSpacing: 25,
        mainAxisSpacing: 20,
        crossAxisCount: 3,
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
            height: 120,
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: AppBoxDecoration.getBorderBoxDecoration(
              showShadow: true,
              blurRadius: 15,
              borderColor: Colors.transparent,
              color: Colors.white,
              borderRadius: 11,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadAssetImage(svgPath),
                const SizedBox(height: 10),
                Text(
                  itemName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontSize: 12,
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


Widget detailsContainer({
  required BuildContext context,
  required List value,
  required List<Color> bgColor,
}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisExtent: MediaQuery.of(context).size.height * 0.22,
    ),
    itemCount: value.length ?? 0,
    itemBuilder: (context, index) {
      final data = value[index];
      final color = bgColor[index];

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        width: 160,
        decoration: AppBoxDecoration.getBoxDecoration(
          color: color ?? AppColors.ultraMarineBlue,
          borderRadius: 15,
          showShadow: false,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Text(
                data.key ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                data.value ?? "",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ],
          ),
        ),
      );
    },
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
