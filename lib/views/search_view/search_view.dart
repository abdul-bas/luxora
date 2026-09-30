import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/utils/get_catogories.dart';
import 'package:luxora/core/utils/pretty_category.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/viewmodels/home_view_model.dart';
import 'package:luxora/views/home/widgets/product_card_widget.dart';

import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  late List<String> _categories;

  @override
  void initState() {
    super.initState();

    _categories = getCategories(widget.products);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final results = vm.apply(widget.products);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: vm.setQuery,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: vm.query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        _controller.clear();
                        vm.setQuery('');
                      },
                    ),
              filled: true,
              fillColor: AppColors.card,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
  
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              itemCount: _categories.length,
              separatorBuilder: (_, __) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (_, i) {
                final category = _categories[i];

                final selected = vm.category == category;

                return ChoiceChip(
                  label: Text(
                    category == 'All' ? 'All' : prettyCategory(category),
                  ),
                  selected: selected,
                  showCheckmark: false,
                  onSelected: (_) {
                    vm.setCategory(category);
                  },
                  selectedColor: AppColors.accent,
                  backgroundColor: AppColors.card,
                  shape: const StadiumBorder(),
                  side: BorderSide(
                    color: selected ? AppColors.accent : AppColors.line,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.onAccent : AppColors.ink,
                  ),
                );
              },
            ),
          ),

          // Results
          Expanded(
            child: results.isEmpty
                ? _emptySearchWidget(vm)
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.62,
                        ),
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return ProductCardWidget(product: results[i]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _emptySearchWidget(HomeViewModel vm) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 56,
            color: AppColors.muted,
          ),
          const SizedBox(height: 12),
          const Text(
            'No products found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              _controller.clear();
              vm.clearAll();
            },
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
  }
}
