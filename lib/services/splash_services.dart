import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/auth/login.dart';

class SplashServices {


  Future<void> moveToNextPage(context) async {
    var data = await SharedPreferences.getInstance();

    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
  }
}
