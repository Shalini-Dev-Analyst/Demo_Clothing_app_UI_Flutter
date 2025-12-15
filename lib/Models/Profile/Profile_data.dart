// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileData {
  static final ValueNotifier<String> userName = ValueNotifier<String>("Hello");
  static final ValueNotifier<String> mobileNumber = ValueNotifier<String>("+91 0000000000");

  /// Load saved user data from SharedPreferences
  static Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('userName') ?? "Hello";
    final savedPhone = prefs.getString('userPhone') ?? "+91 0000000000";

    userName.value = savedName;
    mobileNumber.value = savedPhone;
  }

  /// Save user data to SharedPreferences and notify listeners
  static Future<void> saveUserData(String name, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userPhone', phone);
    userName.value = name;
    mobileNumber.value = phone;
  }

  // Logout: clear all saved data
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userPhone');

    // Reset ValueNotifiers
    userName.value = "";
    mobileNumber.value = "";
  }
}
