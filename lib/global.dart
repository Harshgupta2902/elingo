// Colors class
import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xFF6949FF);
  static const Color secondaryButtonColor = Color(0xFFF0EDFF);
  static const Color borderColor = Color(0xFFEEEEEE);

}

// Images class
class GlobalImages {
  static const String splash = "assets/onboarding/splash.png";

  static const String smile = "assets/onboarding/smile.svg";

// Add more image constants here
}

// Text class
class GlobalText {
  static const String appName = 'Elingo';
// Add more text constants here
}

// Main AppConstants class
class Global {
  Global._();

  static const colors = GlobalColors;
  static const images = GlobalImages;
  static const text = GlobalText;
}
