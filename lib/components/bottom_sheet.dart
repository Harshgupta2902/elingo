import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

void correctAnswerBottomSheet({
  required BuildContext context,
  required VoidCallback correctAnswerButtonPressed,
}) {
  showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    isScrollControlled: false,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (BuildContext context) {
      return Container(
        color: GlobalColors.correctAnswer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  splashRadius: 0,
                  shape: RoundedRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 6)),
                  checkColor: GlobalColors.correctAnswer,
                  activeColor: Colors.white,
                ),
                const Text(
                  'Correct!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                const Spacer(),
                const Icon(
                  Icons.send_sharp,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: GlobalColors.correctAnswer,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: correctAnswerButtonPressed,
              child: const Text(
                "CONTINUE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void wrongAnswerBottomSheet({
  required BuildContext context,
  required VoidCallback wrongAnswerButtonPressed,
  required String correctAnswer,
}) {
  showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    isScrollControlled: false,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (BuildContext context) {
      return Container(
        color: GlobalColors.wrongAnswer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  splashRadius: 0,
                  shape: RoundedRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 6)),
                  checkColor: GlobalColors.wrongAnswer,
                  activeColor: Colors.white,
                ),
                const Text(
                  'Wrong!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                const Spacer(),
                const Icon(
                  Icons.send_sharp,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Correct answer:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              correctAnswer,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: GlobalColors.wrongAnswer,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: wrongAnswerButtonPressed,
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void exitAlert({
  required BuildContext context,
  required VoidCallback onTap,
}) {
  showModalBottomSheet<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    showDragHandle: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you Sure you want to leave the lesson",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 22),
            SvgPicture.asset(GlobalImages.smile, height: 100),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () => MyNavigator.pop(),
              child: Text(
                "Continue",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: GlobalColors.primaryColor),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "Exit",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: GlobalColors.wrongAnswer),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      );
    },
  );
}
