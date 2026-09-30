

import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/viewmodels/auth_viewmodel.dart';

import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    context.read<AuthViewmodel>().validateLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.checkroom_rounded,
                  size: 48,
                  color: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Luxora',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                color: AppColors.onAccent,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Fashion that fits your style',
              style: TextStyle(fontSize: 16, color: AppColors.onAccentSoft),
            ),
            const Spacer(),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.onAccent,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
