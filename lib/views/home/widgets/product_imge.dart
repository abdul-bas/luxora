
import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.url});
  final String url;

  

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => ColoredBox(
    color: AppColors.imageBg,
    child: Center(child: Icon(Icons.broken_image_outlined, size: 40, color: AppColors.inkFaint)),
  )
      ,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : ColoredBox(
    color: AppColors.imageBg,
    child: Center(child: Icon(Icons.checkroom_rounded, size: 40, color: AppColors.inkFaint)),
  )
        
    );
  }
}
