
import 'package:luxora/models/product_model.dart';
import 'package:luxora/views/auth/login_view.dart';
import 'package:luxora/views/categories_view/categories_view.dart';
import 'package:luxora/views/home/home_view.dart';
import 'package:luxora/views/product_details/product_details.dart';
import 'package:luxora/views/search_view/search_view.dart';
import 'package:luxora/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetails = '/product-details';
  static const String categories = '/categories';
  static const String search = '/search';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),

    login: (context) => const LoginPage(),

    home: (context) => const HomeView(),

    productDetails: (context) {
      final product =
          ModalRoute.of(context)!.settings.arguments as ProductModel;

      return ProductDetailsView(
        product: product,
      );
    },

    categories: (context) {
      final categories =
          ModalRoute.of(context)!.settings.arguments as List<ProductModel>;

      return CategoriesView(
        categories: categories,
      );
    },
search: (context) {
  final products =
      ModalRoute.of(context)!.settings.arguments as List<ProductModel>;

  return SearchView(
    products: products,
  );
},
  };
}