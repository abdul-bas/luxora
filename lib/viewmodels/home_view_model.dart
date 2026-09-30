import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luxora/models/brand_model.dart';
import 'package:luxora/models/category_model%20.dart';
import 'package:luxora/models/product_model.dart';
import 'package:luxora/services/api_service.dart';
class HomeViewModel extends ChangeNotifier {
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  List<BrandModel> brands = [];

  List<ProductModel> LoadingMoreProducts = [];

  int _bannerIndex = 0;

  int get bannerIndex => _bannerIndex;

  bool isLoading = false;

  int currentLoadingIndex = 0;
  int nextLoadingIndex = 10;

  String query = '';
  String category = 'All';

  Future<void> setProduct() async {
    final result = await ApiService().getProducts();

    if (result != null) {
      products = result;

     
      LoadingMoreProducts.clear();
      currentLoadingIndex = 0;
      nextLoadingIndex = 10;

     
      loadNextProducts();

      categories.clear();
      brands.clear();

      if (products.isNotEmpty) {
        final categoryNames = <String>{};
        final brandNames = <String>{};

        for (final product in products) {
          if (categoryNames.add(product.category)) {
            categories.add(
              CategoryModel(
                id: product.id,
                name: product.category,
                image: product.images[0],
              ),
            );
          }

          if (product.brand.isNotEmpty &&
              brandNames.add(product.brand)) {
            brands.add(
              BrandModel(
                id: product.id,
                name: product.brand,
                image: product.images[0],
              ),
            );
          }
        }
      }

      notifyListeners();
    }
  }

  void setBannerIndex(int newIndex) {
    _bannerIndex = newIndex;
    notifyListeners();
  }

  void loadNextProducts() {
    if (currentLoadingIndex >= products.length) {
      return;
    }

    final endIndex = nextLoadingIndex > products.length
        ? products.length
        : nextLoadingIndex;

    LoadingMoreProducts.addAll(
      products.sublist(
        currentLoadingIndex,
        endIndex,
      ),
    );

    currentLoadingIndex = endIndex;
    nextLoadingIndex = endIndex + 10;

    notifyListeners();
  }

  
  void setQuery(String value) {
    query = value;
    notifyListeners();
  }

  
  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  
  List<ProductModel> apply(List<ProductModel> source) {
    return source.where((product) {
      final matchesQuery =
          query.isEmpty ||
          product.title.toLowerCase().contains(
                query.toLowerCase(),
              );

      final matchesCategory =
          category == 'All' ||
          product.category == category;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  
  void clearAll() {
    query = '';
    category = 'All';
    notifyListeners();
  }
}