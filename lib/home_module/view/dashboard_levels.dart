import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'dart:math' as math;
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/animated_button.dart';

class DashBoardLevels extends StatefulWidget {
  const DashBoardLevels({super.key});

  @override
  State<DashBoardLevels> createState() => _DashBoardLevelsState();
}

class _DashBoardLevelsState extends State<DashBoardLevels> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late Animation<double> _animation;

  double _scrollOffset = 0.0;
  final int _desiredLevel = 2;
  final int totalLevels = 24;

  double gapHeight = 150.0;
  List<Section>? sections;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollToDesiredLevel(),
      );
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500), // Adjust duration as needed
      );

      // Define animation curve
      _animation = Tween<double>(begin: 0, end: 12)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

      // Start the animation
      _controller.repeat(reverse: true);
      sections = parseSections(jsonString);
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

  // void scrollToDesiredLevel() {
  //   // Calculate the offset for the desired level
  //   final sectionIndex = sections?.indexWhere(
  //           (section) => section.lessons.any((lesson) => lesson.id == _desiredLevel)) ??
  //       0;
  //   final lessonIndex =
  //       sections?[sectionIndex].lessons.indexWhere((lesson) => lesson.id == _desiredLevel) ?? 0;
  //
  //   final itemOffset = sectionIndex * gapHeight * 6 + lessonIndex * gapHeight;
  //   final halfScreenHeight = MediaQuery.of(context).size.height / 2;
  //   _scrollOffset = itemOffset - halfScreenHeight + gapHeight / 2;
  //
  //   _scrollController.animateTo(
  //     _scrollOffset,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }

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
                  bool isDesiredLevel = chapter?[subIndex].id == _desiredLevel;
                  double baseY = int.parse(chapter?[subIndex].id.toString() ?? "") * gapHeight;
                  return Transform.translate(
                    offset: Offset(
                      100 * math.sin((index * gapHeight + baseY) / 150),
                      0,
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          AnimatedButton(
                            shape: BoxShape.circle,
                            onPressed: () {
                              debugPrint("${chapter?[subIndex].id}");
                              MyNavigator.pushNamed(GoPaths.startLesson);
                            },
                            child: Text(
                              chapter?[subIndex].id.toString() ?? "",
                            ),
                          ),
                          if (isDesiredLevel)
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 10,
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Container(
                                    width: 150,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(AssetPath.dialogDown),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: _animation.value),
                                    child: Center(
                                      child: Text(
                                        'Start Now',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: GlobalColors.primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 100,
                color: GlobalColors.secondaryButtonColor,
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
