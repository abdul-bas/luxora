import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:luxora/models/product_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://dummyjson.com/products';

  Future<List<ProductModel>?> getProducts() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List products = data['products'];

        return products
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }

    return null;
  }
}