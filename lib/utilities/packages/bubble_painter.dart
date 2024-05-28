import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class CustomStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the fill
    final Paint fillPaint = Paint()
      ..color = AppColors.alabaster
      ..style = PaintingStyle.fill;

    // Paint for the border
    final Paint borderPaint = Paint()
      ..color = GlobalColors.borderColor // Change this to your desired border color
      ..strokeWidth = 2 // Adjust the border width as needed
      ..style = PaintingStyle.stroke;

    const double triangleH = 20;
    const double triangleW = 35.0;
    final double width = size.width;
    final double height = size.height;

    // Define the rounded rectangle
    final BorderRadius borderRadius = SmoothBorderRadius(cornerRadius: 16);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);

    // Path for the combined shape including triangle and rounded rectangle
    final Path path = Path()
      ..addRRect(outer)
      ..moveTo(width / 2 - triangleW / 2, height)
      ..lineTo(width / 2, height + triangleH)
      ..lineTo(width / 2 + triangleW / 2, height)
      ..close();

    // Draw the filled shape
    canvas.drawPath(path, fillPaint);

    // Draw the border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
