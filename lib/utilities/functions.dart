import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/constants/enums.dart';

TextInputType getKeyboardType(String type) {
  switch (type) {
    case 'number':
      return TextInputType.number;
    case 'email':
      return TextInputType.emailAddress;
    case 'password':
      return TextInputType.visiblePassword;
    default:
      return TextInputType.text;
  }
}

String capitalizeFirstWord(String sentence) {
  if (sentence.isEmpty) return sentence;

  return sentence[0].toUpperCase() + sentence.substring(1);
}

String? validateInput(String type, String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }

  switch (type) {
    case 'number':
      if (!RegExp(r'^\d+$').hasMatch(value)) {
        return 'Please enter a valid number';
      }
      break;
    case 'email':
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      break;
    case 'password':
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      break;
  }
  return null;
}

Widget getIconForLevelState(LevelState state) {
  switch (state) {
    case LevelState.inProgress:
      return const Icon(
        Icons.play_arrow,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    case LevelState.completed:
      return const Icon(
        Icons.check_circle,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    case LevelState.upComing:
      return const Icon(
        Icons.hourglass_empty,
        color: GlobalColors.primaryColor,
        size: 56,
      );
    default:
      return const Icon(
        Icons.help,
        color: GlobalColors.primaryColor,
        size: 56,
      ); // Default icon in case of unknown state
  }
}
