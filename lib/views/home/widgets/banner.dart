import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/routing/app_routes.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: products.take(10).toList().length,
          itemBuilder: (context, index, realIndex) {
            final ProductModel product = products[index];

            return InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.productDetails,
                arguments: product,
              ),
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.accent,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                        );
                      },
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              context.read<HomeViewModel>().setBannerIndex(index);
            },
          ),
        ),

        const SizedBox(height: 7),

        Selector<HomeViewModel, int>(
          selector: (_, p1) => p1.bannerIndex,
          builder: (context, index, child) {
            return AnimatedSmoothIndicator(
              activeIndex: index,
              count: products.take(10).toList().length,
              effect: const ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 7,
                spacing: 6,
                expansionFactor: 3,
                activeDotColor: AppColors.accent,
                dotColor: Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }
}
