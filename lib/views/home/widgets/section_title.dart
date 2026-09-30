
import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget(this.text, {super.key, this.count});
  final String text;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
          if (count != null)
            Text(
              '$count items',
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
