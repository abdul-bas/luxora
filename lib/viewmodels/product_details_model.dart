import 'package:flutter/material.dart';
import 'package:luxora/models/product_model.dart';

class ProductDetailsModelView extends ChangeNotifier {
  ProductModel? _product;
  bool _isFav = false;
  ProductModel? get product => _product;
  bool get isFav => _isFav;
  void setProduct(ProductModel product) {
    _product = product;
    notifyListeners();
  }

  toggleFav() {
    _isFav = !_isFav;
    notifyListeners();
  }

  double get discountedPrice {
    if (_product == null) return 0;

    return _product!.price * (1 - _product!.discountPercentage / 100);
  }

  bool get hasDiscount {
    return (_product?.discountPercentage ?? 0) >= 1;
  }

  bool get inStock => (_product?.stock ?? 0) > 0;

  bool get lowStock =>
      (_product?.stock ?? 0) > 0 && (_product?.stock ?? 0) <= 5;
  
}
