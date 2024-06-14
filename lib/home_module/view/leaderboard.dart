import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      appBar: VocabularyAppBar(
        appBgColor: Colors.transparent,
        title: "Leaderboard",
      ),
      body: Column(
        children: [
          Text(
            "LeaderBoard",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
