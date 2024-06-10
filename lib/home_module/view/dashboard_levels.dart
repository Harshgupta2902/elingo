import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/lesson_functions.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/level_button.dart';

class DashBoardLevels extends StatefulWidget {
  const DashBoardLevels({super.key});

  @override
  State<DashBoardLevels> createState() => _DashBoardLevelsState();
}

class _DashBoardLevelsState extends State<DashBoardLevels> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late Animation<double> _animation;

  final int _desiredLevel = 20;
  final int totalLevels = 36;

  double gapHeight = 90.0;
  List<Section>? sections;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sections = parseSections(jsonString);
      Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollToDesiredLevel(),
      );
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500), // Adjust duration as needed
      );

      _animation = Tween<double>(begin: 0, end: 12)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

      _controller.repeat(reverse: true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up controller
    super.dispose();
  }

  List<Section> parseSections(String jsonString) {
    final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Section>((json) => Section.fromJson(json)).toList();
  }

  static const jsonString = '''
[
  {
    "section": "Section 1",
    "section_name":"Reading",
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
    "section_name":"Writing",
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
    "section": "Section 3",
    "section_name":"Listening",
    "lessons": [
      {"id": 13, "status": "upComing"},
      {"id": 14, "status": "upComing"},
      {"id": 15, "status": "upComing"},
      {"id": 16, "status": "upComing"},
      {"id": 17, "status": "upComing"},
      {"id": 18, "status": "upComing"}
    ]
  },
  {
    "section": "Section 4",
    "section_name":"Speaking",
    "lessons": [
      {"id": 19, "status": "upComing"},
      {"id": 20, "status": "upComing"},
      {"id": 21, "status": "upComing"},
      {"id": 22, "status": "upComing"},
      {"id": 23, "status": "upComing"},
      {"id": 24, "status": "upComing"}
    ]
  },
  {
    "section": "Section 5",
    "section_name":"Combined",
    "lessons": [
       {"id": 25, "status": "upComing"},
      {"id": 26, "status": "upComing"},
      {"id": 27, "status": "upComing"},
      {"id": 28, "status": "upComing"},
      {"id": 29, "status": "upComing"},
      {"id": 30, "status": "upComing"}
    ]
  },
  {
    "section": "Section 6",
    "section_name":"Test",
    "lessons": [
      {"id": 31, "status": "upComing"},
      {"id": 32, "status": "upComing"},
      {"id": 33, "status": "upComing"},
      {"id": 34, "status": "upComing"},
      {"id": 35, "status": "upComing"},
      {"id": 36, "status": "upComing"}
    ]
  }
]
''';

  void scrollToDesiredLevel() {
    final level = totalLevels - _desiredLevel;
    double totalOffset = 0;
    for (int i = 0; i < (sections?.length ?? 0); i++) {
      var chapter = sections?[i].lessons;
      if (chapter != null) {
        for (int j = 0; j < chapter.length; j++) {
          if (chapter[j].id == level) {
            debugPrint(totalOffset.toString());

            _scrollController.animateTo(
              totalOffset,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
            return;
          }
          totalOffset += gapHeight;
        }
      }
      totalOffset += gapHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections?.length ?? 0,
            itemBuilder: (context, index) {
              final chapter = sections?[index].lessons;
              final sectionColor = getColorForSections(index);
              return Column(
                children: [
                  Container(
                    height: 100,
                    color: sectionColor.withOpacity(0.4),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sections?[index].section}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${sections?[index].sectionName}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapter?.length ?? 0,
                    itemBuilder: (context, subIndex) {
                      bool isDesiredLevel = chapter?[subIndex].id == _desiredLevel;
                      double baseY = int.parse(chapter?[subIndex].id.toString() ?? "") * gapHeight;
                      return Transform.translate(
                        offset: Offset(100 * math.sin((index * gapHeight + baseY) / 150), 0),
                        child: SizedBox(
                          height: gapHeight,
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                LevelAnimatedButton(
                                  onPressed: () => MyNavigator.pushNamed(GoPaths.startLesson),
                                  height: 50,
                                  buttonHeight: 10,
                                  width: 65,
                                  backgroundColor: sectionColor,
                                  buttonType: LevelButtonTypes.oval,
                                  child: Text(
                                    chapter?[subIndex].id.toString() ?? "",
                                  ),
                                ),
                                if (isDesiredLevel)
                                  Positioned(
                                    left: -20,
                                    right: -20,
                                    top: -30,
                                    child: AnimatedBuilder(
                                      animation: _controller,
                                      builder: (context, child) {
                                        return Container(
                                          width: 200,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(AssetPath.dialogDown),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, bottom: 12, top: 6),
                                          margin: EdgeInsets.only(top: _animation.value),
                                          child: Text(
                                            'Start Now',
                                            style:
                                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                                      color: GlobalColors.primaryColor,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
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
  final String sectionName;
  final List<Lesson> lessons;

  Section({required this.sectionName, required this.section, required this.lessons});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      section: json['section'] as String,
      sectionName: json['section_name'] as String,
      lessons: (json['lessons'] as List<dynamic>).map((lesson) => Lesson.fromJson(lesson)).toList(),
    );
  }
}
