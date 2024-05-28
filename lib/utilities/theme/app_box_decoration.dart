import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class AppBoxDecoration {
  static BoxDecoration getBoxDecoration({
    double borderRadius = 10,
    Color color = Colors.white,
    double spreadRadius = 0,
    double blurRadius = 20,
    bool showShadow = true,
    Color shadowColor = Colors.black,
    double shadowOpacity = 0.06,
    double offsetX = 0,
    double offsetY = 4,
  }) {
    return BoxDecoration(
      borderRadius: SmoothBorderRadius(
        cornerRadius: borderRadius,
      ),
      color: color,
      boxShadow: [
        if (showShadow)
          BoxShadow(
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            color: shadowColor.withOpacity(shadowOpacity),
            offset: Offset(offsetX, offsetY),
          ),
      ],
    );
  }

  static BoxDecoration getBorderBoxDecoration({
    double borderRadius = 16,
    Color color = Colors.white,
    double borderWidth = 2,
    Color borderColor = GlobalColors.primaryColor,
    double spreadRadius = 0,
    double blurRadius = 24,
    bool showShadow = true,
    Color shadowColor = GlobalColors.primaryColor,
    double offsetX = 4,
    double offsetY = 8,
  }) {
    return BoxDecoration(
      borderRadius: SmoothBorderRadius(
        cornerRadius: borderRadius,
      ),
      color: color,
      border: Border.all(
        width: borderWidth,
        color: borderColor,
      ),
      boxShadow: [
        if (showShadow)
          BoxShadow(
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            color: shadowColor,
            offset: Offset(offsetX, offsetY),
          ),
      ],
    );
  }
}
