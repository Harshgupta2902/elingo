import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/components/cached_image_container.dart';
import 'package:vocablury/dashboard_module/learn_from_videos/controller/get_video_links_controller.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

import '../../../utilities/constants/assets_path.dart';
import '../../../utilities/navigation/go_paths.dart';
import '../model/video_links_model.dart';

final _controller = Get.put(GetYouTubeVideoLinksController());

class VideoLinksView extends StatefulWidget {
  const VideoLinksView({Key? key}) : super(key: key);

  @override
  State<VideoLinksView> createState() => VideoLinksViewState();
}

class VideoLinksViewState extends State<VideoLinksView> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  double _currentScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller.getYouTubeVideoLinks();
    _scrollController.addListener(() {
      setState(() {
        _currentScrollPosition = _scrollController.position.pixels;
        _currentPage = (_currentScrollPosition / 420).round(); // Adjust the width of your items
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Video Links",
        isProfileView: false,
        bgColor: AppColors.zircon,

        actionOnTap: () {
          return;
        },
      ),
      body: _controller.obx(
        (state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text(
                        "Trending ",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                    ),
                    Container(
                      margin:   EdgeInsets.symmetric(horizontal:  (state?.trending?.data?.length ?? 0) < 0 ? 20 : 0),
                      height: MediaQuery.of(context).size.height * 0.30,
                      color: AppColors.zircon,
                      child: Stack(
                        children: [
                          ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state?.trending?.data?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = state?.trending?.data?[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: CachedImageNetworkContainer(
                                  width: 400,
                                  // Adjust the width according to your needs
                                  fit: BoxFit.fitWidth,
                                  decoration: AppBoxDecoration.getBoxDecoration(
                                    showShadow: false,
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    borderRadius: 12,
                                  ),
                                  url: item?.thumbnail ?? "",
                                  placeHolder: const Image(
                                    image: NetworkImage(
                                      "https://i.giphy.com/uIJBFZoOaifHf52MER.webp",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                state?.trending?.data?.length ?? 0,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPage == index
                                          ? AppColors.scienceBlue
                                          : AppColors.scienceBlue.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state?.mainList?.length ?? 0,
                  (context, index) {
                    final key = state?.mainList?[index];
                    final data = key?.data?[index];

                    return buildVideoItem(
                      context: context,
                      data: data!,
                      key: key!,
                    );
                  },
                ),
              ),
            ],
          );
        },
        onError: (error) {
          return const Center(
            child: Text("Custom Error "),
          );
        },
      ),
    );
  }
}

Widget buildVideoItem({required BuildContext context, required Data data, required MainList key}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          key.name ?? "",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      Container(
        height: 140,
        color: AppColors.zircon,
        child: ListView.builder(
          itemCount: key.data?.length ?? 0,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final data = key.data?[index];
            return GestureDetector(
              onTap: () {
                debugPrint("here is the url ${data?.videoLink}");
                context.push(GoPaths.webViewPage, extra: {
                  "url": data?.videoLink ?? "",
                  "title": "Youtube",
                });
              },
              child: Container(
                color: AppColors.zircon,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedImageNetworkContainer(
                      width: 160,
                      height: 80,
                      fit: BoxFit.fitWidth,
                      decoration: AppBoxDecoration.getBoxDecoration(
                        showShadow: true,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        borderRadius: 12,
                        spreadRadius: 1,
                      ),
                      url: data?.thumbnail ?? '',
                      placeHolder: Lottie.asset(
                        AssetPath.loader,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Text(
                        data?.topic ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.black,
                              fontSize: 12,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}
