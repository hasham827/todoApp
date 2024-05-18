import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/provider/session_provider.dart';
import '../repository/model/login_model.dart';
import '../screens/home_page/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPassObscure = true;
   final SessionProvider sessionProvider;
  LoginProvider({required this.sessionProvider});
  bool get isPassObscure => _isPassObscure;
   bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void passObscureFun() {
    _isPassObscure = !_isPassObscure;
    notifyListeners();
  }

  Future<void> onLogin() async {
    if (formKey.currentState!.validate()) {
      loading=true;
      notifyListeners();
      const url = 'https://dummyjson.com/auth/login';
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': usernameController.text.trim(),
        // 'kminchelle',
        'password': passwordController.text.trim(),
        // '0lelplR',
        'expiresInMins': 30, // optional, defaults to 60
      });

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          loading=false;
          notifyListeners();
          print(" herer is respponse data ${responseData}");
          LoginData loginData = LoginData.fromJson(jsonDecode(response.body.toString()));
          print(" herer is respponse data ${loginData.username}");
          sessionProvider.addUserData(loginData);
          Get.offAll(const  HomeScreen());
           // handle the response data as needed
        } else {
          loading=false;
          notifyListeners();
          print('Failed to log in. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred during login: $error');
      }

    }
  }
}
