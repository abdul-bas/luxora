import 'package:luxora/models/category_model%20.dart';
import 'package:luxora/models/product_model.dart';

List<ProductModel> findProductsByCategory(CategoryModel category,List<ProductModel>products) {
  return products
      .where(
        (product) => product.category.toLowerCase() == category.name.toLowerCase(),
      )
      .toList();
}