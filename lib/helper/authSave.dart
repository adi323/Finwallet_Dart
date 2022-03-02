import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class authSave {
  saveLoginData(Map data) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setBool('user', true);
    await sh.setString('id', data['id']);
    await sh.setString('email', data['email']);
    await sh.setString('name', data['name']);
    await sh.setString('profile_img', data['profile_img']);
  }

  static Future<bool?> getLoggedinStatus() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getBool('user');
  }

  static Future<String?> getId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('id');
  }

  static Future<String?> getEmail() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('email');
  }

  static Future<String?> getName() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('name');
  }

  static Future<String?> getImg() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('profile_img');
  }

  static Future<bool?> logoutDevice() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setBool('user', false);
  }
}
