import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/views/home/widgets/pill.dart';
import 'package:luxora/views/home/widgets/product_imge.dart';
import 'package:luxora/views/home/widgets/tag.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
   

    return InkWell(
     onTap: () => Navigator.pushNamed(
  context,
  '/product-details',
  arguments: product,
),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ProductImageWidget(url: product.thumbnail),
                  if (product.discountPercentage >= 1)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: TagWidget('-${product.discountPercentage.round()}%'),
                    ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.card,
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 18,
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Pill(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: AppColors.star,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (product.stock <= 5)
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Pill(
                        child: Text(
                          product.stock == 0
                              ? 'Sold out'
                              : 'Only ${product.stock} left',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.sale,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
      
       
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (product.brand.isNotEmpty)
                    Text(
                      product.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppColors.ink,
                              ),
                            ),
                            if (product.discountPercentage >= 1)
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColors.accent,
                        child: Icon(
                          Icons.add_rounded,
                          size: 20,
                          color: AppColors.onAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
