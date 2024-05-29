import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

import 'utilities/navigation/route_generator.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Vocablury',
      routerConfig: goRouterConfig,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: false,
        primaryColor: GlobalColors.primaryColor,
        fontFamily: 'Quicksand',
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 6)),
          splashRadius: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.primaryColor,
            foregroundColor: Colors.white,
            minimumSize: Size(MediaQuery.of(context).size.width, 52),
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius(cornerRadius: 34),
            ),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
