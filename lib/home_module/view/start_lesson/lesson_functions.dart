import 'package:flutter/material.dart';
import 'package:vocablury/components/bottom_sheet.dart';

void handleAnswer(
    {required String questionType,
    required String correctSentence,
    required dynamic answerMap,
    required VoidCallback correctAnswerButtonPressed,
    required VoidCallback wrongAnswerButtonPressed,
    required PageController pageController,
    required BuildContext context}) {
  switch (questionType) {
    case "translate":
      checkTranslateSentence(
        correctSentence: correctSentence,
        selectedWords: answerMap,
        correctAnswerButtonPressed: correctAnswerButtonPressed,
        wrongAnswerButtonPressed: wrongAnswerButtonPressed,
        context: context,
      );
      break;
    case "speaking":
      checkSpeakingSentence(
        correctSentence: correctSentence,
        mappedSentence: answerMap,
        correctAnswerButtonPressed: correctAnswerButtonPressed,
        wrongAnswerButtonPressed: wrongAnswerButtonPressed,
        context: context,
      );
      break;
    case "meaning":
      checkMeaningSentence(
        correctSentence: correctSentence,
        mappedSentence: answerMap,
        correctAnswerButtonPressed: correctAnswerButtonPressed,
        wrongAnswerButtonPressed: wrongAnswerButtonPressed,
        context: context,
      );
      break;
    case "listening":
      checkTranslateSentence(
        correctSentence: correctSentence,
        selectedWords: answerMap,
        correctAnswerButtonPressed: correctAnswerButtonPressed,
        wrongAnswerButtonPressed: wrongAnswerButtonPressed,
        context: context,
      );
      break;
    default:
      // Handle default case if necessary
      break;
  }
}

void checkTranslateSentence(
    {required List selectedWords,
    required String correctSentence,
    required VoidCallback correctAnswerButtonPressed,
    required VoidCallback wrongAnswerButtonPressed,
    required BuildContext context}) {
  debugPrint("$selectedWords    $correctSentence");

  String selectedSentence = selectedWords.join(' ');
  if (selectedSentence == correctSentence) {
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    wrongAnswerBottomSheet(
      wrongAnswerButtonPressed: wrongAnswerButtonPressed,
      correctAnswer: correctSentence,
      context: context,
    );
  }
}

void checkSpeakingSentence({
  required String mappedSentence,
  required String correctSentence,
  required VoidCallback correctAnswerButtonPressed,
  required BuildContext context,
  required VoidCallback wrongAnswerButtonPressed,
}) {
  debugPrint("$mappedSentence    $correctSentence");

  if (correctSentence.toLowerCase() == mappedSentence.toLowerCase()) {
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    wrongAnswerBottomSheet(
      wrongAnswerButtonPressed: wrongAnswerButtonPressed,
      correctAnswer: correctSentence,
      context: context,
    );
  }
}

void checkMeaningSentence({
  required String correctSentence,
  required String mappedSentence,
  required VoidCallback correctAnswerButtonPressed,
  required BuildContext context,
  required VoidCallback wrongAnswerButtonPressed,
}) {
  debugPrint("$mappedSentence    $correctSentence");

  if (correctSentence.toLowerCase() == mappedSentence.toLowerCase()) {
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    wrongAnswerBottomSheet(
      wrongAnswerButtonPressed: wrongAnswerButtonPressed,
      correctAnswer: correctSentence,
      context: context,
    );
  }
}
