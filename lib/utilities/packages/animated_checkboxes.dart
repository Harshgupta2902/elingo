import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class AnimatedCheckBoxes extends StatefulWidget {
  const AnimatedCheckBoxes({
    Key? key,
    required this.value,
    this.isDisabled = false,
    this.checkedColor,
    this.size = 18,
    this.borderRadius = 8,
    this.duration,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final bool isDisabled;
  final Color? checkedColor;
  final double size;
  final Duration? duration;
  final double? borderRadius;
  final void Function(bool selected) onChanged;

  @override
  State<AnimatedCheckBoxes> createState() => _AnimatedCheckBoxesState();
}

class _AnimatedCheckBoxesState extends State<AnimatedCheckBoxes>
    with SingleTickerProviderStateMixin {
  double get _strokeWidth => 6 * (widget.size / 60);

  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();
    if (widget.value) {
      animationController.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCheckBoxes oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationController.duration = const Duration(milliseconds: 400);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isDisabled) {
          widget.onChanged(!widget.value);
        }
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.size + _strokeWidth,
            width: widget.size + _strokeWidth,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: SmoothBorderRadius(cornerRadius: widget.borderRadius ?? 8),
                border: Border.all(
                  color: GlobalColors.primaryColor,
                  width: _strokeWidth,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: widget.size,
              minWidth: widget.size,
            ),
            child: AnimatedCheckBoxBaseClass(
              context: context,
              isDisabled: widget.isDisabled,
              animation: animationController,
              strokeWidth: _strokeWidth,
              size: widget.size,
              borderRadius: widget.borderRadius ?? 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class AnimatedCheckBoxBaseClass extends StatelessWidget {
  final Animation<double> animation;
  final BuildContext context;
  final bool isDisabled;
  final double size;
  final double strokeWidth;
  final double borderRadius;

  const AnimatedCheckBoxBaseClass({
    Key? key,
    required this.animation,
    required this.context,
    required this.isDisabled,
    required this.size,
    required this.strokeWidth,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FillCheckBoxComponent(parent: this);
  }
}

class FillCheckBoxComponent extends StatelessWidget {
  final AnimatedCheckBoxBaseClass parent;

  const FillCheckBoxComponent({Key? key, required this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = parent.animation.drive(
      Tween(begin: 0.0, end: parent.size + parent.strokeWidth).chain(
        CurveTween(
          curve: Curves.easeOutCirc,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final size = parent.size * 0.4;
        return Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: animation.value,
              width: animation.value,
              decoration: BoxDecoration(
                borderRadius: SmoothBorderRadius(cornerRadius: parent.borderRadius),
                color: GlobalColors.primaryColor,
              ),
            ),
            Opacity(
              opacity: parent.animation.value,
              child: CustomPaint(
                painter: _CheckPainter(
                  fillPercentage: 1,
                  strokeWidth: parent.strokeWidth,
                  color: Colors.white,
                ),
                size: Size(size, size),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CheckPainter extends CustomPainter {
  final double fillPercentage;
  final double strokeWidth;
  final Color color;

  _CheckPainter({
    required this.fillPercentage,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const corner = 0.3;
    final path = Path();
    final centerAdjustment = corner / 2 * size.height;

    final segment1Scale = fillPercentage < corner ? fillPercentage / corner : 1;
    final segment2Scale = (fillPercentage - corner) / (1 - corner);

    path.moveTo(0, (1 - corner) * size.height - centerAdjustment);

    if (fillPercentage > 0) {
      path.lineTo(
        corner * size.width * segment1Scale,
        (1 - corner) * size.height + corner * segment1Scale * size.height - centerAdjustment,
      );
    }

    if (fillPercentage > corner) {
      path.lineTo(
        corner * size.width + (1 - corner) * size.width * segment2Scale,
        size.height - (1 - corner) * size.height * segment2Scale - centerAdjustment,
      );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) {
    return fillPercentage != oldDelegate.fillPercentage;
  }
}
