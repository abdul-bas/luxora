import 'package:flutter/material.dart';
import 'package:luxora/core/routing/app_routes.dart';
import 'package:luxora/views/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewmodel extends ChangeNotifier {
  bool _obscure = true;
  bool _loading = false;
  bool _success = false;
  bool _submitted = false;
  bool _disposed = false;
  String? _banner;

  bool get obscure => _obscure;
  bool get loading => _loading;
  bool get success => _success;

  bool get submitted => _submitted;

  String? get banner => _banner;

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void markSubmitted() {
    _submitted = true;
    _banner = null;
    notifyListeners();
  }

  String? validateId(String? value) {
    final v = value?.trim() ?? '';

    if (v.isEmpty) {
      return 'Enter your email or phone number';
    }

    if (v.contains('@') && v.contains('.')) {
      return null;
    }

    final digits = v.replaceAll(RegExp(r'\D'), '');

    if (digits.length >= 10 && digits.length <= 15) {
      return null;
    }

    return 'Enter a valid email or phone number';
  }

  String? validatePassword(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Enter your password.';
    if (v.length < 8) return 'Password must be at least 8 characters.';
    return null;
  }

  Future<bool> login(String id, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _loading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1200));

    final ok =
        id.trim().toLowerCase() == 'demo@example.com' &&
        password == 'Demo@1234';
    _loading = false;
    if (ok) {
      pref.setBool("isLogin", true);
      _success = true;
    } else {
      _banner = 'Incorrect email, phone number or password. Check your details and try again.';
    }
    notifyListeners();
    return ok;
  }

  void navigateToHome(BuildContext context, bool success) {
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> submit(
    GlobalKey<FormState> formKey,
    TextEditingController idCtrl,
    TextEditingController pwCtrl,
    BuildContext context,
  ) async {
    markSubmitted();

    if (!formKey.currentState!.validate()) {
      return;
    }
    await login(idCtrl.text, pwCtrl.text);
  }

  Future<void> validateLogin(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    final isLoggedIn = pref.getBool("isLogin") ?? false;
    if (!context.mounted) return;
    if (isLoggedIn) {
     Navigator.pushReplacementNamed(
  context,
  AppRoutes.home,
);
    }else{
      Navigator.pushReplacementNamed(
  context,
  AppRoutes.login,
);
    }
  }
}
