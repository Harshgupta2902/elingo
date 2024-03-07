import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocablury/components/app_bar/custom_app_bar.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';

class ChooseMockTestScreen extends StatefulWidget {
  const ChooseMockTestScreen({super.key});

  @override
  State<ChooseMockTestScreen> createState() => _ChooseMockTestScreenState();
}

class _ChooseMockTestScreenState extends State<ChooseMockTestScreen> {
  late Box<bool> submittedBox;
  late List<bool> submittedList = [];

  final dynamicQuizApiList = [
    "https://run.mocky.io/v3/9f42f0bb-cde5-45bd-95c3-94a6c1cbb0fd",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
    "https://run.mocky.io/v3/f182d03e-562d-41d5-9894-a247307775b0",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/d303fe66-e401-446a-a0be-d2eeb6bcbaa0",
    "https://run.mocky.io/v3/0b47d609-8d14-4e09-95a5-17b30e0652dc",
    "https://run.mocky.io/v3/240cfd1c-4738-4195-b971-f6a714f08e78",
    "https://run.mocky.io/v3/5add3902-7fc1-48dd-8ccc-24837f6cce06",
  ];




  @override
  initState() {
    super.initState();
    _openBoxAndRetrieveData();
  }

  //   - ----------- get data from Hive database -------------------

  Future<void> _openBoxAndRetrieveData() async {
    // Open the Hive box
    submittedBox = await Hive.openBox<bool>('submittedBox');

    // Retrieve the data from the box
    for (int i = 0; i < submittedBox.length; i++) {
      submittedList.add(submittedBox.get(i) ?? false);
    }

    // Set the state to rebuild the UI with the retrieved data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zircon,
      appBar: CustomAppBar(
        title: "Choose Mock Test",
        isProfileView: false,
        bgColor: AppColors.zircon,
        actionOnTap: () {
          return;
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.white,
                showShadow: true,
                borderRadius: 10,
                shadowColor: AppColors.zircon,
                spreadRadius: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Course Progress",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.blueBayoux,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "60%",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.blueBell,
                                ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        AssetPath.goldCup,
                        height: 45,
                        width: 45,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const LinearProgressIndicator(
                    color: AppColors.scienceBlue,
                    backgroundColor: AppColors.porcelain,
                    value: 0.6,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.22,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: dynamicQuizApiList.length ?? 0,
                  itemBuilder: (context, index) {

                    final apiUrl = dynamicQuizApiList[index];

                    return GestureDetector(
                      onTap: () {
                        context.push(
                          GoPaths.dailyQuizScreen,
                          extra: {
                            "apiUrl": apiUrl,
                            "CompletedIndex": index,
                          },
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: AppBoxDecoration.getBorderBoxDecoration(
                          showShadow: true,
                          shadowColor: AppColors.brightGrey.withOpacity(0.05),
                          color: AppColors.white,
                          borderRadius: 16,
                          blurRadius: 6,
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
                                    "Mock Tests",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Practice Makes a Man Perfect!",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Image.asset(
                                  AssetPath.image,
                                  height: 65,
                                  width: 65,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
