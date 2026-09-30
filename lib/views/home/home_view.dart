import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

import 'package:luxora/viewmodels/home_view_model.dart';
import 'package:luxora/views/home/widgets/banner.dart';
import 'package:luxora/views/home/widgets/categories_strip.dart';
import 'package:luxora/views/home/widgets/product_card_widget.dart';
import 'package:luxora/views/home/widgets/search_widget.dart';
import 'package:luxora/views/home/widgets/section_title.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final p = context.read<HomeViewModel>();
    p.setProduct();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        p.loadNextProducts();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        titleSpacing: 20,
        title: const Text(
          'Luxora',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
         
         if (value.products.isEmpty) {
    return Center(child: CircularProgressIndicator(color: AppColors.accent));
  }
          return CustomScrollView(
            controller: scrollController,
            slivers: [
               SliverToBoxAdapter(child: SearchWidget(products: value.products,)),
              SliverToBoxAdapter(child: const SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: PromoBannerWidget(products: value.products),
              ),
              const SliverToBoxAdapter(child: SectionTitleWidget('Categories')),
              SliverToBoxAdapter(
                child: CategoryStripWidget(categories: value.categories,products:value.products,),
              ),
              SliverToBoxAdapter(
                child: SectionTitleWidget(
                  'New Arrivals',
                  count: value.LoadingMoreProducts.length,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 24),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: value.LoadingMoreProducts.length,
                  itemBuilder: (_, i) =>
                      ProductCardWidget(product: value.LoadingMoreProducts[i]),
                ),
              ),
         if(value.isLoading)SliverToBoxAdapter(child: CircularProgressIndicator(color: AppColors.accentSoft,),)   ],
          );
       
        },
      ),
    );
  }
}
