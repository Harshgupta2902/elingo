import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/auth_module/login/view/login_view.dart';
import 'package:vocablury/components/web_view.dart';
import 'package:vocablury/dashboard_module/learn_from_videos/video_links_page.dart';
import 'package:vocablury/dashboard_module/quiz/view/choose_flash_cards_category_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/choose_mock_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/listening_practice_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/quiz_result_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/quiz_screen.dart';
import 'package:vocablury/dashboard_module/quiz/view/quiz_with_timer_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/quiz_without_timer_view.dart';
import 'package:vocablury/dashboard_module/quiz/view/reading_screen_view.dart';
import 'package:vocablury/dashboard_module/search_vocablury/view/dictionary_screen_view.dart';
import 'package:vocablury/dashboard_module/view/dashboard_view.dart';
import 'package:vocablury/flash_cards/view/category_view_components.dart';
import 'package:vocablury/flash_cards/view/custom_flash_cards.dart';
import 'package:vocablury/utilities/fcm_services/notification_web_view.dart';
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
      name: GoPaths.dictionary,
      builder: (context, state) {
        return const DictionaryScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.loginView,
      name: GoPaths.loginView,
      builder: (context, state) {
        return const LoginView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.chooseMockTestScreen,
      name: GoPaths.chooseMockTestScreen,
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
      name: GoPaths.dashBoard,
      builder: (context, state) {
        return const DashboardView();
      },
    ),

    //  ---- test liked added or not ----
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.likedFlashCardsView,
      name: GoPaths.likedFlashCardsView,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final dbName = extraParams['dbName'];
        final title = extraParams['title'];
        return LikedFlashCardsView(
          dbName: dbName,
          title: title,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.notificationWebView,
      name: GoPaths.notificationWebView,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final url = extraParams['url'];
        final title = extraParams['title'];
        return NotificationWebView(
          url: url,
          title: title,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.customFlashCards,
      name: GoPaths.customFlashCards,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final categoryName = extraParams['categoryName'];
        final dbName = extraParams['dbName'];
        return CustomFlashCards(
          categoryName: categoryName,
          dbName: dbName,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.onboardingQuestions,
      name: GoPaths.onboardingQuestions,
      builder: (context, state) {
        return const OnboardingQuestions();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.videoLinksView,
      name: GoPaths.videoLinksView,
      builder: (context, state) {
        return const VideoLinksView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.chooseFlashCardScreen,
      name: GoPaths.chooseFlashCardScreen,
      builder: (context, state) {
        return const ChooseFlashCardScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.readingScreen,
      name: GoPaths.readingScreen,
      builder: (context, state) {
        return const ReadingScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.irregularVerbsScreen,
      name: GoPaths.irregularVerbsScreen,
      builder: (context, state) {
        return const IrregularVerbsScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dailyQuizScreen,
      name: GoPaths.dailyQuizScreen,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final apiUrl = extraParams['apiUrl'];
        final completedIndex = extraParams['CompletedIndex'];
        final onTestCompleted = extraParams['onTestCompleted'];

        return DailyQuizScreen(
          apiUrl: apiUrl,
          completedIndex: completedIndex,
          onTestCompleted: onTestCompleted,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.quizResultView,
      name: GoPaths.quizResultView,
      builder: (context, state) {
        final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        final userAnswers = extraParams['userAnswers'];
        final questions = extraParams['questions'];

        return QuizResultView(
          questions: questions,
          userAnswers: userAnswers,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.resultPage,
      name: GoPaths.resultPage,
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

    //  ---------------------- common web view page -------------------------
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.webViewPage,
      name: GoPaths.webViewPage,
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
