import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/componants/container_for_test.dart';
import 'package:vocablury/dashboard_module/componants/dashboard_custom_components.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
import 'package:vocablury/utilities/fcm_services/dynamic_link_service.dart';
import 'package:vocablury/utilities/fcm_services/firebase_notification_service.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    FCMNotificationService().updateFCMToken();
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? value) {
      if (value != null) {
        FCMNotificationService().onNotificationClicked(payload: value.data, path: "home view");
      }
    });
  }

  final controller = CarouselController();
  int activeIndex = 0;

  final realUserPost = [
    "Team Lead",
    "Co-founder",
    "Manager",
  ];

  var _isScrolledToTop = false;
  final _scrollController = DraggableScrollableController();

  void _onScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.size >= 0.85) {
        setState(() {
          _isScrolledToTop = true;
        });
      } else {
        setState(() {
          _isScrolledToTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scienceBlue,
      appBar: CustomAppBar(
        title: "Vocablury",
        isProfileView: true,
        bgColor: AppColors.scienceBlue,
        actionOnTap: () {
          SystemNavigator.pop();
        },
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.scienceBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                      children: <InlineSpan>[
                        TextSpan(
                            text: 'How to Teach ESL Vocabulary: ',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                        TextSpan(
                            text: 'Top Methods for Introducing ',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                        TextSpan(
                            text: ' New Words',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        context.push(GoPaths.videoLinksView);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        foregroundColor: AppColors.white,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        side: const BorderSide(color: Colors.white, width: 2.0),
                        minimumSize: const Size(50, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Watch Now",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AssetPath.videoIcon,
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
                    ),
                    Lottie.asset(
                      AssetPath.busLottie,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            snap: true,
            initialChildSize: 0.65,
            snapSizes: const [0.65],
            minChildSize: 0.65,
            maxChildSize: 0.98,
            controller: _scrollController,
            builder: (context, scrollController) {
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                  color: AppColors.zircon,
                  borderRadius: _isScrolledToTop
                      ? null
                      : const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: _isScrolledToTop == false ? 6 : 0,
                            width: _isScrolledToTop == false ? 52 : 0,
                            decoration: const BoxDecoration(
                              color: AppColors.cadetGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      buildGridContainers(
                        context: context,
                        svgPaths: [
                          AssetPath.accommodation,
                          AssetPath.dashIcon,
                          AssetPath.reading,
                          AssetPath.dashIcon,
                          AssetPath.music,
                          AssetPath.flash
                        ],
                        svgData: [
                          "Vocabulary Building",
                          "Grammar",
                          "Reading Comprehension",
                          "Dictionary",
                          "Listening Practice",
                          "Flash Cards",
                        ],
                        routesData: [
                          "videoLinksView",
                          "readingScreen",
                          "readingScreen",
                          "dictionary",
                          "irregularVerbsScreen",
                          "chooseFlashCardScreen",
                        ],
                      ),
                      const TakeTest(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  color: AppColors.scienceBlue,
                                  blurRadius: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Get 20% OFF on IELTS",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: AppColors.white, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Get Special Discount on IELTS packages for you",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.white.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  color: AppColors.darkMintGreen,
                                  blurRadius: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Get 20% OFF on IELTS",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: AppColors.white, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Get Special Discount on IELTS packages for you",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.white.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kToolbarHeight - 20),
                      Center(
                        child: Text(
                          "Students Reviews",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.black,
                              ),
                        ),
                      ),
                      CarouselSlider.builder(
                        carouselController: controller,
                        itemCount: 3,
                        itemBuilder: (context, index, realIndex) {
                          final data = [
                            KeyValuePair(
                              key: "Real Review",
                              value:
                                  " In addition to a critical evaluation, the review's author may assign the work a rating to indicate its relative merit",
                              path: AssetPath.user,
                            ),
                            KeyValuePair(
                              key: "Real Review",
                              value:
                                  " In addition to a critical evaluation, the review's author may assign the work a rating to indicate its relative merit",
                              path: AssetPath.user,
                            ),
                            KeyValuePair(
                              key: "Real Review",
                              value:
                                  " In addition to a critical evaluation, the review's author may assign the work a rating to indicate its relative merit",
                              path: AssetPath.user,
                            ),
                          ];

                          final userData = data[index];

                          final userPost = realUserPost[index];

                          return buildScrollContainers(
                            context: context,
                            description: userData.value,
                            userName: userData.key,
                            userImg: userData.path,
                            userPost: userPost,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          pauseAutoPlayOnTouch: false,
                          viewportFraction: 0.80,
                          enlargeCenterPage: true,
                          padEnds: true,
                          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                          onPageChanged: (index, reason) => setState(() => activeIndex = index),
                          pageSnapping: false,
                          scrollDirection: Axis.horizontal,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      ),
                      const SizedBox(height: kToolbarHeight),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
