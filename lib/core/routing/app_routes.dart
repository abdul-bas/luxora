import 'package:luxora/views/auth/login_view.dart';
import 'package:luxora/views/home/home_view.dart';
import 'package:luxora/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';



class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),
    login: (context) => const LoginPage(),
    home: (context) => const HomeView(),
  };
}