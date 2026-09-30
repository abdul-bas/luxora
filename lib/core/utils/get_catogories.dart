import 'package:luxora/models/product_model.dart';

List<String> getCategories(List<ProductModel> products) {
  return [
    'All',
    ...{
      for (final product in products) product.category,
    },
  ];
}