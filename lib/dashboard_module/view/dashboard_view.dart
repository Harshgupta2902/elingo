import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/dashboard_module/componants/dashboard_custom_components.dart';
import 'package:vocablury/dashboard_module/componants/take_test.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/key_value_pair.dart';
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
  }

  final controller = CarouselController();
  int activeIndex = 0;

  final svgPaths = [
    AssetPath.accommodation,
    AssetPath.dashIcon,
    AssetPath.reading,
    AssetPath.dashIcon,
    AssetPath.music,
    AssetPath.flash,
  ];

  final svgData = [
    "Vocabulary Building",
    "Grammar",
    "Reading Comprehension",
    "Dictionary",
    "Listening Practice",
    "Flash Cards",
  ];

  final routesData = [
    "videoLinksView",
    "readingScreen",
    "readingScreen",
    "dictionary",
    // "likedFlashCardsView",

    "irregularVerbsScreen",
    "chooseFlashCardScreen",
  ];

  final bgColors = [
    AppColors.lavenderMist,
    AppColors.tequila,
    AppColors.aeroBlue,
    AppColors.moonRaker,
  ];

  final detailsContainerBgColors = [
    AppColors.ultraMarineBlue,
    AppColors.darkMintGreen,
    AppColors.darkMintGreen,
    AppColors.ultraMarineBlue,
  ];

  final borderColorsList = [
    AppColors.pastelBlue,
    AppColors.sand,
    AppColors.lightBluishGreen,
    AppColors.babyPurple,
  ];

  final titleList = [
    " Class Schedule",
    " Mock Tests",
    "Today’s Tasks",
    "Practice Tests",
  ];

  final realUserPost = [
    "Team Lead",
    "Co-founder",
    "Manager",
  ];

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
                      children: const <InlineSpan>[
                        TextSpan(
                          text: 'Take IELTS Pre-Test and\n',
                        ),
                        TextSpan(
                          text: 'Access Your English ',
                        ),
                        TextSpan(
                          text: ' Proficiency Level',
                        ),
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
                      style: getOutlinedButtonStyle(
                        backgroundColor: Colors.white.withOpacity(
                          0.3,
                        ),
                        foregroundColor: AppColors.white,
                        borderColor: Colors.white,
                        width: 50,
                        height: 40,
                        borderRadius: 10,
                        buttonColor: Colors.white,
                        showShadow: false,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Watch Now",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: SvgPicture.asset(
                              AssetPath.videoIcon,
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Lottie.asset(
                      AssetPath.busLottie,
                      height: 180,
                      width: 200,
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
            builder: (context, scrollController) {
              return Container(
                decoration: AppBoxDecoration.getBoxDecoration(color: AppColors.zircon),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 80,
                              decoration: AppBoxDecoration.getBoxDecoration(color: AppColors.cadetGrey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                        child: Text(
                          "Dashboard",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.scienceBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      buildGridContainers(
                        context: context,
                        svgPaths: svgPaths,
                        svgData: svgData,
                        routesData: routesData,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: TakeTest(),
                      ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
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
                            const SizedBox(width: 18),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
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
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Real Reviews",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  "From Real Students.",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: AppColors.scienceBlue,
                                      ),
                                ),
                              ],
                            ),
                          ],
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
                      const SizedBox(height: 50)
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
