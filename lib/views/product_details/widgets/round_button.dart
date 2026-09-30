

import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

class RoundButtonWidget extends StatelessWidget {
  const RoundButtonWidget({super.key, required this.icon, required this.onPressed,this.color});
  final IconData icon;
  final VoidCallback onPressed;
 final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon,color: color,),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.ink,
      ),
    );
  }
}