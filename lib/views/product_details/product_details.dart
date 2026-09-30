import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/core/utils/pretty_category.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/viewmodels/product_details_model.dart';
import 'package:luxora/views/product_details/widgets/chip.dart';
import 'package:luxora/views/product_details/widgets/perk.dart';
import 'package:luxora/views/product_details/widgets/round_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
 @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;

    context.read<ProductDetailsModelView>().setProduct(
      widget.product,
    );
  });
}
  @override
  
void dispose() {
   
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsModelView>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(28),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 360,
                            color: AppColors.imageBg,
                            child: Image.network(
                              widget.product.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RoundButtonWidget(
                                  icon: Icons.arrow_back_rounded,
                                  onPressed: () => Navigator.pop(context),
                                ),
                                RoundButtonWidget(
                                  color: value.isFav ? AppColors.error : null,
                                  icon: value.isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  onPressed: () {
                                    value.toggleFav();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ChipWidget(
                                prettyCategory(widget.product.category),
                                color: AppColors.accent,
                              ),
                              if (widget.product.brand.isNotEmpty) ...[
                                const SizedBox(width: 10),
                                Text(
                                  widget.product.brand,
                                  style: const TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 12),

                          Text(
                            widget.product.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.star,
                                size: 22,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 14),
                              ChipWidget(
                                !value.inStock
                                    ? 'Out of stock'
                                    : value.lowStock
                                    ? 'Only ${widget.product.stock} left'
                                    : '${widget.product.stock} in stock',
                                color: value.inStock && value.lowStock
                                    ? AppColors.success
                                    : AppColors.sale,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${value.discountedPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent,
                                ),
                              ),
                              if (value.hasDiscount) ...[
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '\$${widget.product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.muted,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: ChipWidget(
                                    '${widget.product.discountPercentage.round()}% OFF',
                                    color: AppColors.sale,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 22),

                          const Row(
                            children: [
                              PerkWidget(
                                Icons.local_shipping_outlined,
                                'Free delivery',
                              ),
                              SizedBox(width: 10),
                              PerkWidget(
                                Icons.autorenew_rounded,
                                'Easy returns',
                              ),
                              SizedBox(width: 10),
                              PerkWidget(
                                Icons.verified_user_outlined,
                                'Secure payment',
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),

                          // ── Description ──
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              height: 1.6,
                              fontSize: 15,
                              color: AppColors.muted,
                            ),
                          ),

                          if (widget.product.images.length > 1) ...[
                            const SizedBox(height: 26),
                            const Text(
                              'More photos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 90,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.product.images.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (_, i) => ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    width: 90,
                                    color: AppColors.imageBg,
                                    child: Image.network(
                                      widget.product.images[i],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            decoration: const BoxDecoration(
              color: AppColors.card,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total price',
                        style: TextStyle(color: AppColors.muted, fontSize: 12),
                      ),
                      Text(
                        '\$${value.discountedPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: value.inStock ? () {} : null,
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: Text(
                        value.inStock ? 'Add to Cart' : 'Out of Stock',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
