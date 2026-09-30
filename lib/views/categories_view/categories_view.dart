import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/utils/pretty_category.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/views/home/widgets/product_card_widget.dart';



class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.categories});

  final List<ProductModel> categories;

  @override
  Widget build(BuildContext context) {
    final title = categories.isEmpty
        ? 'Category'
        : prettyCategory(categories.first.category);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: categories.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off_rounded, size: 56, color: AppColors.muted),
                  SizedBox(height: 12),
                  Text(
                    'No products found',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text(
                    '${categories.length} items',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) =>
                        ProductCardWidget(product: categories[index]),
                  ),
                ),
              ],
            ),
    );
  }
}