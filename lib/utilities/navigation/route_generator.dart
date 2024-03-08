import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/web_view.dart';
import 'package:vocablury/dashboard_module/learn_from_videos/video_links_page.dart';
import 'package:vocablury/dashboard_module/quiz/view/choose_flash_cards.dart';
import 'package:vocablury/dashboard_module/quiz/view/choose_mock_test.dart';
import 'package:vocablury/dashboard_module/quiz/view/daily_quiz_screen.dart';
import 'package:vocablury/dashboard_module/quiz/view/listening_practice.dart';
import 'package:vocablury/dashboard_module/quiz/view/quiz_screen.dart';
import 'package:vocablury/dashboard_module/quiz/view/reading_screen.dart';
import 'package:vocablury/dashboard_module/quiz/view/result_screen.dart';
import 'package:vocablury/dashboard_module/search_vocablury/view/dictionary_screen.dart';
import 'package:vocablury/dashboard_module/view/dashboard_view.dart';
import 'package:vocablury/flash_cards/view/category_view_components.dart';
import 'package:vocablury/flash_cards/view/custom_flash_cards.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter goRouterConfig = GoRouter(
  // initialLocation: GoPaths.serOnBoardingScreen,
  initialLocation: GoPaths.dashBoard,

  navigatorKey: rootNavigatorKey,
  routes: [
    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) {
    //     return SerchWordMean();
    //   },
    //   routes: const [
    //     // GoRoute(
    //     //   parentNavigatorKey: shellNavigatorKey,
    //     //   path: GoPaths.home,
    //     //   builder: (context, state) {
    //     //     return const HomeScreenView();
    //     //   },
    //     // ),
    //     // GoRoute(
    //     //   parentNavigatorKey: shellNavigatorKey,
    //     //   path: GoPaths.page1,
    //     //   builder: (context, state) {
    //     //     return Page1();
    //     //   },
    //     // ),
    //
    //   ],
    // ),

    // -------------------------------------- X --------------------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dictionary,
      builder: (context, state) {
        return const DictionaryScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.chooseMockTestScreen,
      builder: (context, state) {
        return const ChooseMockTestScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.quizScreen,
      builder: (context, state) {
        return const QuizScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dashBoard,
      builder: (context, state) {
        return const DashboardView();
      },
    ),

    //  -------------------------- test liked added or not
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.likedFlashCardsView,
      builder: (context, state) {
        return const LikedFlashCardsView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.customFlashCards,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final categoryName = extraParams['categoryName'];
        return CustomFlashCards(
          categoryName: categoryName,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.videoLinksView,
      builder: (context, state) {
        return const VideoLinksView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.chooseFlashCardScreen,
      builder: (context, state) {
        return const ChooseFlashCardScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.readingScreen,
      builder: (context, state) {
        return const ReadingScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.irregularVerbsScreen,
      builder: (context, state) {
        return const IrregularVerbsScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dailyQuizScreen,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final apiUrl = extraParams['apiUrl'];
        final completedIndex = extraParams['CompletedIndex'];

        return DailyQuizScreen(
          apiUrl: apiUrl,
          completedIndex: completedIndex,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.resultPage,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final questions = extraParams['questions'];
        final selectedAnswers = extraParams['selectedAnswers'];
        final correctCount = extraParams['correctCount'];
        final totalTimeInSeconds = extraParams['totalTimeInSeconds'];

        return ResultPage(
          questions: questions,
          selectedAnswers: selectedAnswers,
          totalTimeInSeconds: totalTimeInSeconds,
          correctCount: correctCount,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.testResultPage,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final questions = extraParams['questions'];
        final selectedAnswers = extraParams['selectedAnswers'];
        final correctCount = extraParams['correctCount'];
        final totalTimeInSeconds = extraParams['totalTimeInSeconds'];
        return TestResultPage(
          questions: questions,
          selectedAnswers: selectedAnswers,
          totalTimeInSeconds: totalTimeInSeconds,
          correctCount: correctCount,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.webViewPage,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>;
        final url = extraParams['url'];
        final title = extraParams['title'];
        return WebViewPage(
          url: url,
          title: title,
        );
      },
    ),
  ],
);
