
import 'package:flutter/material.dart';

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
