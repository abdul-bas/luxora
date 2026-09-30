import 'package:flutter/material.dart';
IconData iconFor(String c) {
  final category = c.toLowerCase();

  if (category.contains('beauty')) {
    return Icons.face_retouching_natural;
  }

  if (category.contains('fragrances')) {
    return Icons.spa_outlined;
  }

  if (category.contains('furniture')) {
    return Icons.chair_outlined;
  }

  if (category.contains('groceries')) {
    return Icons.local_grocery_store_outlined;
  }

  return Icons.category_outlined;
}