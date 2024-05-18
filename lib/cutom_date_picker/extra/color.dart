import 'package:flutter/material.dart';
class AppColors {
  AppColors._();

  static const Color defaultDateColor = Colors.black;
  static const Color defaultDayColor = Colors.black;
  static const Color kPrimaryColor = Color(0xff3CFEDE);
  static const Color defaultMonthColor = Colors.black;
  static const Color defaultSelectionColor = Color(0x30000000);
  static const Color defaultDeactivatedColor = Color(0xFF666666);
  static const  LinearGradient kButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3263B0),
      Color(0xFF3CFEDE),
    ],
  );

  static const  LinearGradient kBorderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3CFEDE),
      Color(0xFF3263B0),

    ],
  );
  static const  LinearGradient kDotGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF3CFEDE),
      Color(0xFF3263B0),

    ],
  );
}
