import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:vocablury/components/bottom_sheet.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/home_module/view/start_lesson/flutter_speak.dart';
import 'package:vocablury/home_module/view/start_lesson/flutter_tts.dart';
import 'package:vocablury/home_module/view/start_lesson/listening_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/matching_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/meaning_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/speak_questions.dart';
import 'package:vocablury/home_module/view/start_lesson/translate_questions.dart';

TextToSpeechService ttsService = TextToSpeechService();

Widget getQuestionWidget({
  required String questionType,
  required String questionHeading,
  required String ques,
  required List<dynamic> options,
  required String questionUrl,
  required String correctSentence,
  required Map<String, dynamic> answerMap,
  required VoidCallback onChange,
}) {
  switch (questionType) {
    case "translate":
      return TranslateQuestions(
        questionHeading: questionHeading,
        question: ques,
        jumbledWords: options,
        answerMap: answerMap,
        onChange: onChange,
      );
    case "speaking":
      return SpeakingQuestions(
        questionHeading: questionHeading,
        correctSentence: ques,
        answerMap: answerMap,
        onChange: onChange,
      );
    case "meaning":
      return MeaningQuestions(
        options: options,
        questionHeading: questionHeading,
        correctSentence: ques,
        answerMap: answerMap,
        onChange: onChange,
      );
    case "listening":
      return ListeningQuestions(
        options: options,
        questionHeading: questionHeading,
        questionUrl: questionUrl,
        answerMap: answerMap,
        onChange: onChange,
      );
    case "matching":
      return MatchingQuestions(
        options: options,
        questionHeading: questionHeading,
        answerMap: answerMap,
        onChange: onChange,
        question: ques,
      );
    default:
      return Container();
  }
}

Widget getSpeakerWidget({required String question, required BuildContext context}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () => ttsService.speak(question),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: GlobalColors.primaryColor,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.volume_up, color: Colors.white, size: 26),
        ),
      ),
      const SizedBox(width: 16),
      Flexible(
        child: Text(
          question,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

Future<void> vibratePhone() async {
  bool? hasVibrator = await Vibration.hasVibrator();
  if (hasVibrator == true) {
    Vibration.vibrate(amplitude: 128);
  }
}

void handleAnswer({
  required String questionType,
  required String correctSentence,
  required dynamic answerMap,
  required VoidCallback correctAnswerButtonPressed,
  required VoidCallback wrongAnswerButtonPressed,
  required BuildContext context,
}) {
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

    case "matching":
      checkMatchingQuestion(
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

void checkTranslateSentence({
  required List selectedWords,
  required String correctSentence,
  required VoidCallback correctAnswerButtonPressed,
  required VoidCallback wrongAnswerButtonPressed,
  required BuildContext context,
}) {
  debugPrint("$selectedWords    $correctSentence");

  String selectedSentence = selectedWords.join(' ');
  if (selectedSentence == correctSentence) {
    playAudio(audio: GlobalAudio.correctAnswerAudio);
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    playAudio(audio: GlobalAudio.wrongAnswerAudio);
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
    playAudio(audio: GlobalAudio.correctAnswerAudio);
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    playAudio(audio: GlobalAudio.wrongAnswerAudio);
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
    playAudio(audio: GlobalAudio.correctAnswerAudio);
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    playAudio(audio: GlobalAudio.wrongAnswerAudio);
    wrongAnswerBottomSheet(
      wrongAnswerButtonPressed: wrongAnswerButtonPressed,
      correctAnswer: correctSentence,
      context: context,
    );
  }
}

void checkMatchingQuestion({
  required String selectedWords,
  required String correctSentence,
  required VoidCallback correctAnswerButtonPressed,
  required VoidCallback wrongAnswerButtonPressed,
  required BuildContext context,
}) {
  debugPrint("$selectedWords    $correctSentence");

  String selectedSentence = selectedWords;
  if (selectedSentence == correctSentence) {
    playAudio(audio: GlobalAudio.correctAnswerAudio);
    correctAnswerBottomSheet(
      correctAnswerButtonPressed: correctAnswerButtonPressed,
      context: context,
    );
  } else {
    playAudio(audio: GlobalAudio.wrongAnswerAudio);
    wrongAnswerBottomSheet(
      wrongAnswerButtonPressed: wrongAnswerButtonPressed,
      correctAnswer: correctSentence,
      context: context,
    );
  }
}

String getQuestionHeading(String questionType) {
  switch (questionType) {
    case "translate":
      return "Translate this Sentence";
    case "speaking":
      return "Speak this Sentence";
    case "meaning":
      return "What does this sentence mean?";
    case "listening":
      return "What does this audio say?";
    case "matching":
      return "Tap the matching word pair";
    default:
      return "Translate this Sentence";
  }
}
