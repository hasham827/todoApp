import 'package:flutter/material.dart';

class AppColors {
  static const Color kPrimaryColor = Color(0xff3CFEDE);
  static const Color kSecondaryColor = Color(0xff12305B);
  static const Color kRedColor = Colors.red;
  static const Color kGreenColor = Colors.green;
  static  Color kPendingColor = Colors.amber.shade300;
  static const Color kBackgroundColor = Color(0xffFFFFFF);
  static const Color kWhiteColor = Color(0xffFFFFFF);
  static const Color kBlackColor = Color(0xff000000);
  static const Color kUnselectedColor = Color(0xffA0ACBD);
  /// button gradient
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

  /// textColor 9E9E9E
  static const Color kGreyTextColor = Color(0xff9E9E9E);
  static const Color kBlackTextColor = Color(0xff000000);

}