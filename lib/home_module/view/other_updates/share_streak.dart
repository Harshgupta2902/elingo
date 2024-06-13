import 'package:flutter/material.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class ShareStreak extends StatelessWidget {
  const ShareStreak({super.key});

  @override
  Widget build(BuildContext context) {
    final social = [
      {'image': AssetPath.whatsapp, 'name': 'WhatsApp'},
      {'image': AssetPath.facebook, 'name': 'Facebook'},
      {'image': AssetPath.instagram, 'name': 'Instagram'},
      {'image': AssetPath.linkedIn, 'name': 'LinkedIn'},
      {'image': AssetPath.telegram, 'name': 'Telegram'},
      {'image': AssetPath.twitter, 'name': 'Twitter'},
    ];
    return Scaffold(
      appBar: VocabularyAppBar(
        leadingWidget: IconButton(
          splashRadius: 1,
          splashColor: Colors.transparent,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              MyNavigator.pop();
            }
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: "Share",
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: SmoothBorderRadius(cornerRadius: 26),
                  border: Border.all(color: GlobalColors.borderColor, width: 2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: Column(
                  children: [
                    const Text("🔥", style: TextStyle(fontSize: 100)),
                    const SizedBox(height: 20),
                    Text(
                      "5 Days Streak!",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      GlobalText.appName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, color: GlobalColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: SmoothBorderRadius(cornerRadius: 26),
                    border: Border.all(color: GlobalColors.borderColor, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Image.asset(social[index]['image']!, height: 40),
                            const SizedBox(width: 20),
                            Text(
                              "${social[index]['name']}",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                      itemCount: social.length)),
            ],
          ),
        ),
      ),
    );
  }
}
