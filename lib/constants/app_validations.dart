import 'package:flutter/cupertino.dart';

class AppValidations {
  /// validate username
  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }
    return null;
  }

  /// validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else {
      RegExp emailRegExp = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }

    return null;
  }

  /// validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 6) {
      return 'Please length should be 6 characters';
    }
    return null;
  }

  /// password match
  String? validatePasswordMatch(
    String? value, {
    required String currentPassText,
  }) {
    debugPrint('Validating: value=$value, currentPassText=$currentPassText');
    if (value == null || value.isEmpty) {
      return 'Please enter password again';
    } else if (value != currentPassText) {
      return 'Password not matched';
    }
    return null;
  }

  /// value required
  String? valueRequired(
    String? value, {
    required String errorText,
  }) {
    if (value == null || value.isEmpty) {
      return errorText;
    }
    return null;
  }
}
