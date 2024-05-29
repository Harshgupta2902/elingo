import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
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

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final prefs = GetStorage();

final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.login,
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
