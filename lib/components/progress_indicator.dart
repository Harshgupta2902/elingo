import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocablury/dashboard_module/quiz/controller/daily_quiz_controller.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

final _quizController = Get.put(GetDailyQuizController());

class CircularProgressWidget extends StatefulWidget {
  final Stream<int> timerStream; // Stream of dynamic total duration of the timer
  final void Function(int) onTimeElapsed; // Callback for providing remaining seconds
  final Stream<bool> restartStream; // Stream to trigger timer restart

  const CircularProgressWidget({
    Key? key,
    required this.timerStream,
    required this.onTimeElapsed,
    required this.restartStream,
  }) : super(key: key);

  @override
  CircularProgressWidgetState createState() => CircularProgressWidgetState();
}

class CircularProgressWidgetState extends State<CircularProgressWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _secondsElapsed = 0;
  late StreamSubscription<int> _streamSubscription; // Subscription to the timer stream

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0), // Initial duration of 0 seconds
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    // Listen to changes in the timer stream
    _streamSubscription = widget.timerStream.listen((totalSeconds) {
      debugPrint("Total seconds: $totalSeconds");
      _controller.duration = Duration(seconds: totalSeconds); // Update timer duration
      _startTimer(totalSeconds); // Start the timer with new duration
    });

    // Listen to changes in the restart stream
    widget.restartStream.listen((restart) {
      if (restart) {
        _restartTimer();
      }
    });
  }

  void _startTimer(int totalSeconds) {
    _controller.reset(); // Reset animation controller
    _secondsElapsed = 0; // Reset elapsed seconds
    _controller.forward(); // Start animation
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsElapsed < totalSeconds) {
        setState(() {
          _secondsElapsed++;
          widget.onTimeElapsed(totalSeconds - _secondsElapsed); // Call callback with remaining seconds
          _animation = Tween<double>(
            begin: (_secondsElapsed - 1) / totalSeconds * 100,
            end: _secondsElapsed / totalSeconds * 100,
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          );
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _restartTimer() {
    _controller.stop(); // Stop the current animation
    _streamSubscription.cancel(); // Cancel the current subscription
    _controller.reset(); // Reset animation controller
    _secondsElapsed = 0; // Reset elapsed seconds
    _controller.forward(); // Start animation again
    // Listen to changes in the timer stream again
    _streamSubscription = widget.timerStream.listen((totalSeconds) {
      debugPrint("Total seconds: $totalSeconds");
      _controller.duration = Duration(seconds: totalSeconds); // Update timer duration
      _startTimer(totalSeconds); // Start the timer with new duration
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size.square(150),
          painter: CircularProgressPainter(
            percentage: _animation.value,
            strokeWidth: 5, // You can set your desired default value
            backgroundColor: AppColors.zircon, // You can set your desired default value
            progressColor: Colors.blue, // You can set your desired default value
          ),
        ),
        Text(
          '$_secondsElapsed s',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.scienceBlue,
                fontSize: 24.0,
              ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription.cancel(); // Cancel stream subscription
    super.dispose();
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final foregroundPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressAngle = 2 * pi * (percentage / 100);

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
