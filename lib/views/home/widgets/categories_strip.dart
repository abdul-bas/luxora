import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/routing/app_routes.dart';
import 'package:luxora/core/utils/find_categories.dart'
    show findProductsByCategory;
import 'package:luxora/core/utils/find_icons_for_categories.dart';
import 'package:luxora/models/category_model%20.dart';
import 'package:luxora/models/product_model.dart';

class CategoryStripWidget extends StatelessWidget {
  const CategoryStripWidget({super.key, required this.categories,required this.products});
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) => InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.categories,
              arguments: findProductsByCategory(categories[i], products),
            );
          },
          child: SizedBox(
            width: 72,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.accentSoft,
                  child: Icon(
                    iconFor(categories[i].name),
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  categories[i].name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
