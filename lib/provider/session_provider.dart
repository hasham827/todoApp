import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../repository/model/login_model.dart';
class SessionProvider extends ChangeNotifier {
  LoginData loginData = LoginData();

  final String id = 'id';
  final String avatar = 'avatar';
  final String token = 'token';
  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String email = 'email';
  final String gender = 'gender';
  final String username = 'username';
  /// //Add user data after sign-in or successful-sign-yp
  Future<void> addUserData(LoginData putUser) async {
    var data = await SharedPreferences.getInstance();
    try {
      await data.setInt(id, putUser.id!);
      await data.setString(token, putUser.token ?? '');
      await data.setString(firstName, putUser.firstName ?? '');
      await data.setString(lastName, putUser.lastName ?? '');
      await data.setString(gender, putUser.gender ?? '');
      await data.setString(email, putUser.email ?? '');
      await data.setString(username, putUser.username ?? '');
      await data.setString(avatar, putUser.image ?? "");

    } catch (e, stackTrace) {
      log('Error in data Saving: ${e.toString()} ${stackTrace.toString()}');
    }
  }

  ///
  /// Get Data from database (Verify the existence of previously logged-in user)
  Future<void> getData() async {
    var data = await SharedPreferences.getInstance();
    try{
      loginData.id = data.getInt(id);
      loginData.image = data.getString(avatar);
      loginData.token = data.getString(token);
      loginData.firstName = data.getString(firstName);
      loginData.lastName = data.getString(lastName);
      loginData.email = data.getString(email);
      loginData.username = data.getString(username);
      loginData.gender = data.getString(gender);
      notifyListeners();
    }catch(e){
      log('Error: ${e.toString()}');
    }
  }

  ///
  /// Sign-out from database (remove user)
  Future<void> logout() async {
    var data = await SharedPreferences.getInstance();
    await data.remove(id);
    await data.remove(avatar);
    await data.remove(token);
    await data.remove(firstName);
    await data.remove(lastName);
    await data.remove(email);
    await data.remove(gender);
    await data.remove(username);
    notifyListeners();
  }

}