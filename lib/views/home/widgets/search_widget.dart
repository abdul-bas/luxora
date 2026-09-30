import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/routing/app_routes.dart';
import 'package:luxora/models/product_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key,required this.products});
final  List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: SearchBar(
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.search, arguments: products),
        hintText: 'Search clothes, brands...',
        hintStyle: const WidgetStatePropertyAll(
          TextStyle(color: AppColors.muted, fontSize: 14),
        ),
        leading: const Icon(Icons.search_rounded, color: AppColors.muted),
        trailing: const [Icon(Icons.tune_rounded, color: AppColors.accent)],
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: const WidgetStatePropertyAll(AppColors.card),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16),
        ),
        constraints: const BoxConstraints(minHeight: 50),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
