import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/enums.dart';
import 'package:vocablury/utilities/functions.dart';
import 'dart:math' as math;
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';

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
  final int _desiredLevel = 20;
  final int totalLevels = 24;

  double gapHeight = 98.0;
  List<Section>? sections;

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
      {"id": 13, "status": "completed"},
      {"id": 14, "status": "completed"},
      {"id": 15, "status": "completed"},
      {"id": 16, "status": "completed"},
      {"id": 17, "status": "completed"},
      {"id": 18, "status": "inProgress"}
    ]
  },
  {
    "section": "Section 2",
    "lessons": [
      {"id": 19, "status": "upComing"},
      {"id": 20, "status": "upComing"},
      {"id": 21, "status": "upComing"},
      {"id": 22, "status": "upComing"},
      {"id": 23, "status": "upComing"},
      {"id": 24, "status": "upComing"}
    ]
  }
]
''';

  void scrollToDesiredLevel() {
    setState(() {
      _scrollOffset = (totalLevels - _desiredLevel) * gapHeight;
    });

    _scrollController.animateTo(
      _scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color color = GlobalColors.primaryColor;

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

                  // LevelState state;
                  //
                  // if (chapter?[subIndex].status == 'completed') {
                  //   state = LevelState.completed;
                  // } else if (chapter?[subIndex].status == 'inProgress') {
                  //   state = LevelState.inProgress;
                  // } else {
                  //   state = LevelState.upComing;
                  // }
                  //
                  // Widget icon = getIconForLevelState(state);

                  // return Transform.translate(
                  //   offset: Offset(
                  //     100 * math.sin((index * gapHeight + baseY) / 150),
                  //     0,
                  //   ),
                  //   child: GestureDetector(
                  //     child: Container(
                  //       height: 56,
                  //       width: 56,
                  //       margin: const EdgeInsets.symmetric(vertical: 25),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(chapter?[subIndex].id.toString() ?? ""),
                  //           const SizedBox(width: 10),
                  //           icon,
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                  return Transform.translate(
                      offset: Offset(
                        100 * math.sin((index * gapHeight + baseY) / 150),
                        0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("${chapter?[subIndex].id}");
                          MyNavigator.pushNamed(GoPaths.startLesson);
                        },
                        child: ClipRect(
                          clipBehavior: Clip.hardEdge,
                          child: AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 160, vertical: 25),
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                            child: Center(
                              child: Text(
                                chapter?[subIndex].id.toString() ?? "",
                              ),
                            ),
                          ),
                        ),
                      )
                      // Flat3dButton.text(
                      //   onPressed: () {
                      //     debugPrint("${chapter?[subIndex].id}");
                      //     MyNavigator.pushNamed(GoPaths.startLesson);
                      //   },
                      //   text: chapter?[subIndex].id.toString() ?? "",
                      // ),
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
                  child: Text("${sections?[index].section}"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
