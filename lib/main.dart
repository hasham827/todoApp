import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/providers_list.dart';
import 'package:todo/repository/dbHelper/dbhelper.dart';
import 'package:todo/screens/splash/splash_page.dart';
import 'constants/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ToDoDatabaseHelper dbHelper = ToDoDatabaseHelper.internal();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList().appProviders(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kSecondaryColor),
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.kWhiteColor, // AppBar background color
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.kWhiteColor, // Status bar background color
              statusBarIconBrightness: Brightness.dark, // Status bar icon color
              statusBarBrightness: Brightness.light, // Status bar brightness for iOS
            ),
          ),
        ),
        home:   const SplashPage(),
      ),
    );
  }
}

