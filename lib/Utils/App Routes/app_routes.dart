import 'package:flutter/cupertino.dart';
import '../../View/Account Screen/AccountScreen.dart';
import '../../View/Category Screen/categoryscreen.dart';
import '../../View/Home Screen/homescreen.dart';
import '../../View/Initial Screen/initialscreen.dart';
import '../../View/Login Screen /loginscreen.dart';
import '../../View/Register Screen/registerscreen.dart';
import '../../View/Splash Screen/splashscreen.dart';

class AppRoutes {
  static String splash = '/';
  static String initial = '/initial';
  static String login = '/login';
  static String otp = '/otp';
  static String home = '/home';
  static String register = '/register';
  static String category = '/category';
  static String account = '/account';


  static Map<String, WidgetBuilder> routes = {
    splash: (context) => Splashscreen(),
    initial: (context) => Initialscreen(),
    login: (context) => Loginscreen(),
    home: (context) => Homescreen(),
    register: (context) => Registerscreen(),
    category: (context)=> Categoryscreen(),
    account: (context)=> Accountscreen(),
  };
}