

import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

class LabelWidget  extends StatelessWidget {
  const LabelWidget (this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.ink,
        ),
      ),
    );
  }
}