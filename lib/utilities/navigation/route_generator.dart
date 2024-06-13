import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/home_module/view/buy_diamonds/buy_diamonds.dart';
import 'package:vocablury/home_module/view/buy_diamonds/payment_success.dart';
import 'package:vocablury/home_module/view/buy_diamonds/review_summary.dart';
import 'package:vocablury/home_module/view/buy_diamonds/select_payment_method.dart';
import 'package:vocablury/home_module/view/landing_view.dart';
import 'package:vocablury/home_module/view/other_updates/daily_streak.dart';
import 'package:vocablury/home_module/view/other_updates/daily_mission_updates.dart';
import 'package:vocablury/home_module/view/other_updates/share_streak.dart';
import 'package:vocablury/home_module/view/start_lesson/lesson_complete.dart';
import 'package:vocablury/home_module/view/start_lesson/question_view.dart';
import 'package:vocablury/home_module/view/start_lesson/start_lesson.dart';
import 'package:vocablury/onboarding_module/view/create_profile_form.dart';
import 'package:vocablury/onboarding_module/view/onboarding_questions_screen.dart';
import 'package:vocablury/onboarding_module/view/onboarding_screen.dart';
import 'package:vocablury/onboarding_module/view/onboarding_success_screen.dart';
import 'package:vocablury/onboarding_module/view/profile_success_screen.dart';
import 'package:vocablury/onboarding_module/view/splash_screen.dart';
import 'package:vocablury/registration_module/view/create_password_screen.dart';
import 'package:vocablury/registration_module/view/forgot_password_screen.dart';
import 'package:vocablury/registration_module/view/login_screen.dart';
import 'package:vocablury/registration_module/view/otp_screen.dart';
import 'package:vocablury/registration_module/view/password_success_screen.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/home_module/view/dashboard_levels.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final prefs = GetStorage();

final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.dailyStreak,
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

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.login,
      name: GoPaths.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.forgotPassword,
      name: GoPaths.forgotPassword,
      builder: (context, state) {
        return const ForgotPasswordScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.otpScreen,
      name: GoPaths.otpScreen,
      builder: (context, state) {
        return const OtpScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.createPassword,
      name: GoPaths.createPassword,
      builder: (context, state) {
        return const CreatePasswordScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.passwordSuccess,
      name: GoPaths.passwordSuccess,
      builder: (context, state) {
        return const PasswordSuccessScreen();
      },
    ),

    // // -------------------------------------- NAV BAR Routes --------------------------------------

    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return LandingView(
          child: child,
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: GoPaths.dashboardLevels,
          name: GoPaths.dashboardLevels,
          builder: (context, state) {
            return const DashBoardLevels();
          },
        ),
        // GoRoute(
        //   parentNavigatorKey: shellNavigatorKey,
        //   path: GoPaths.dashboardLevels1,
        //   name: GoPaths.dashboardLevels1,
        //   builder: (context, state) {
        //     return const DashBoardLevels();
        //   },
        // ),
      ],
    ),

    // // -------------------------------------- BUY DIAMONDS Routes --------------------------------------
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.buyDiamonds,
      name: GoPaths.buyDiamonds,
      builder: (context, state) {
        return const BuyDiamonds();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.selectPaymentMethod,
      name: GoPaths.selectPaymentMethod,
      builder: (context, state) {
        return const SelectPaymentMethod();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.reviewSummary,
      name: GoPaths.reviewSummary,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final selectedPaymentMethod = extras["selectedPaymentMethod"];
        return ReviewSummary(
          selectedPaymentMethod: selectedPaymentMethod,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.paymentSuccess,
      name: GoPaths.paymentSuccess,
      builder: (context, state) {
        return const PaymentSuccessScreen();
      },
    ),

    // // -------------------------------------- START LESSON Routes --------------------------------------
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.startLesson,
      name: GoPaths.startLesson,
      builder: (context, state) {
        return const StartLessonScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.questionsView,
      name: GoPaths.questionsView,
      builder: (context, state) {
        return const QuestionsView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.lessonComplete,
      name: GoPaths.lessonComplete,
      builder: (context, state) {
        return const LessonComplete();
      },
    ),

    // // -------------------------------------- Other Updates Routes --------------------------------------
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dailyMissionUpdates,
      name: GoPaths.dailyMissionUpdates,
      builder: (context, state) {
        return const DailyMissionUpdates();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dailyStreak,
      name: GoPaths.dailyStreak,
      builder: (context, state) {
        return const DailyStreak();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.shareStreak,
      name: GoPaths.shareStreak,
      builder: (context, state) {
        return const ShareStreak();
      },
    ),
  ],
);
