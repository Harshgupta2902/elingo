import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/onboarding_module/view/create_profile_form.dart';
import 'package:vocablury/onboarding_module/view/onboarding_questions_screen.dart';
import 'package:vocablury/onboarding_module/view/onboarding_screen.dart';
import 'package:vocablury/onboarding_module/view/onboarding_success_screen.dart';
import 'package:vocablury/onboarding_module/view/profile_success_screen.dart';
import 'package:vocablury/onboarding_module/view/splash_screen.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final prefs = GetStorage();

final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.createProfileForm,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.splash,
      name: GoPaths.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.onBoarding,
      name: GoPaths.onBoarding,
      builder: (context, state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.onBoardingQuestions,
      name: GoPaths.onBoardingQuestions,
      builder: (context, state) {
        return const OnboardingQuestionsScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.onboardingSuccessScreen,
      name: GoPaths.onboardingSuccessScreen,
      builder: (context, state) {
        return const OnboardingSuccessScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.createProfileForm,
      name: GoPaths.createProfileForm,
      builder: (context, state) {
        return const CreateProfileForm();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.profileSuccessScreen,
      name: GoPaths.profileSuccessScreen,
      builder: (context, state) {
        return const ProfileSuccessScreen();
      },
    ),

    // // -------------------------------------- NAV BAR Routes --------------------------------------

    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) {
    //     return LandingView(
    //       child: child,
    //     );
    //   },
    //   routes: [
    //     GoRoute(
    //       parentNavigatorKey: shellNavigatorKey,
    //       path: GoPaths.setting,
    //       name: GoPaths.setting,
    //       builder: (context, state) {
    //         return const SettingScreen();
    //       },
    //     ),
    //     GoRoute(
    //       parentNavigatorKey: shellNavigatorKey,
    //       path: GoPaths.ieltsDashboard,
    //       name: GoPaths.ieltsDashboard,
    //       builder: (context, state) {
    //         return const IeltsDashboardView();
    //       },
    //     ),
    //   ],
    // ),

    // // -------------------------------------- SETTING ROUTES Routes --------------------------------------
  ],
);
