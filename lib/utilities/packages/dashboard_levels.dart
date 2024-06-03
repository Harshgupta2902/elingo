import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'dart:math' as math;

enum LevelState {
  inProgress,
  completed,
  upComing,
}

class Lesson {
  final int id;
  final String status;

  Lesson({required this.id, required this.status});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int,
      status: json['status'] as String,
    );
  }
}

class Section {
  final String section;
  final List<Lesson> lessons;

  Section({required this.section, required this.lessons});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      section: json['section'] as String,
      lessons: (json['lessons'] as List<dynamic>).map((lesson) => Lesson.fromJson(lesson)).toList(),
    );
  }
}

class DashBoardLevels extends StatefulWidget {
  const DashBoardLevels({super.key});

  @override
  State<DashBoardLevels> createState() => _DashBoardLevelsState();
}

class _DashBoardLevelsState extends State<DashBoardLevels> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  final int _desiredLevel = 1;

  double gapHeight = 98.0;
  List<Section>? sections;
  // final List<Section> sections = parseSections(jsonString);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollToDesiredLevel(),
      );
      sections = parseSections(jsonString);
    });
  }

  List<Section> parseSections(String jsonString) {
    final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Section>((json) => Section.fromJson(json)).toList();
  }

  static const jsonString = '''
  [
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    }, 
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    },
    {
      "section": "Section 1",
      "lessons": [
        {"id": 1, "status": "completed"},
        {"id": 2, "status": "completed"},
        {"id": 3, "status": "completed"},
        {"id": 4, "status": "completed"},
        {"id": 5, "status": "completed"},
        {"id": 6, "status": "inProgress"}
      ]
    },
    {
      "section": "Section 2",
      "lessons": [
        {"id": 7, "status": "upComing"},
        {"id": 8, "status": "upComing"},
        {"id": 9, "status": "upComing"},
        {"id": 10, "status": "upComing"},
        {"id": 11, "status": "upComing"},
        {"id": 12, "status": "upComing"}
      ]
    }
  ]
  ''';

  void scrollToDesiredLevel() {
    setState(() {
      _scrollOffset = (99 - _desiredLevel) * gapHeight;
    });

    _scrollController.animateTo(
      _scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: ListView.separated(
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections?.length ?? 0,
            itemBuilder: (context, index) {
              final chapter = sections?[index].lessons;
              return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chapter?.length ?? 0,
                itemBuilder: (context, subIndex) {
                  double baseY = subIndex * gapHeight;
                  LevelState state;

                  if (chapter?[subIndex].status == 'completed') {
                    state = LevelState.completed;
                  } else if (chapter?[subIndex].status == 'inProgress') {
                    state = LevelState.inProgress;
                  } else {
                    state = LevelState.upComing;
                  }

                  Widget icon = getIconForLevelState(state);
                  return Transform.translate(
                    offset: Offset(
                      100 * math.sin((index * gapHeight + baseY) / 150),
                      0,
                    ),
                    child: GestureDetector(
                      child: Container(
                        height: 56,
                        width: 56,
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(index.toString()),
                            const SizedBox(width: 10),
                            icon,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 100,
                color: GlobalColors.primaryColor,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("Lesson $index"),
                ),
              );
            },
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: SingleChildScrollView(
    //       controller: _scrollController,
    //       physics: const BouncingScrollPhysics(),
    //       child: ListView.builder(
    //         shrinkWrap: true,
    //         reverse: true,
    //         physics: const NeverScrollableScrollPhysics(),
    //         itemCount: levels.length,
    //         itemBuilder: (context, index) {
    //           double baseY = index * gapHeight;
    //
    //           LevelState state;
    //           if (index < _desiredLevel) {
    //             state = LevelState.completed;
    //           } else if (index == _desiredLevel) {
    //             state = LevelState.inProgress;
    //           } else {
    //             state = LevelState.upComing;
    //           }
    //
    //           Widget icon = getIconForLevelState(state);
    //           return Transform.translate(
    //             offset: Offset(
    //               100 * math.sin(baseY / 150),
    //               0,
    //             ),
    //             child: GestureDetector(
    //               child: Container(
    //                 height: 56,
    //                 width: 56,
    //                 margin: const EdgeInsets.symmetric(vertical: 25),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(index.toString()),
    //                     const SizedBox(width: 10),
    //                     icon,
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}

Widget getIconForLevelState(LevelState state) {
  switch (state) {
    case LevelState.inProgress:
      return const Icon(
        Icons.play_arrow,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    case LevelState.completed:
      return const Icon(
        Icons.check_circle,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    case LevelState.upComing:
      return const Icon(
        Icons.hourglass_empty,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    default:
      return const Icon(
        Icons.help,
        color: GlobalColors.primaryColor,
        size: 56,
      ); // Default icon in case of unknown state
  }
}
