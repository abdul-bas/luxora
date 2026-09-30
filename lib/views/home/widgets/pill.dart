import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

class Pill extends StatelessWidget {
  const Pill({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}