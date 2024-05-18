import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../provider/session_provider.dart';
import '../../services/splash_services.dart';
import '../auth/login.dart';
import '../home_page/home_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  setdata() async {
    final sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    await sessionProvider.getData();
    print("here is ${sessionProvider.loginData.token}");
    Timer(
      const Duration(seconds: 4),
      () {
        if(sessionProvider.loginData.token==null){
          Get.offAll(() =>const LoginPage());
        }else{
          Get.offAll(() =>const HomeScreen());
        }

      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      /// body
      body: Container(
        decoration: const BoxDecoration(
            gradient: AppColors.kBorderGradient
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   AppImages.appLogo,
              //   height: height(context) * 0.3,
              // ),
              CircularProgressIndicator(
                backgroundColor: AppColors.kSecondaryColor,
                color: AppColors.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
