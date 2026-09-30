class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      brand: json['brand'] ?? '',
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images'] ?? []),
    );
  }

  // ---- Helpers used by the UI ----

  /// Price after the discount is applied (what the customer pays).
  /// [price] is treated as the original price.
  double get finalPrice => price * (1 - discountPercentage / 100);

  bool get hasDiscount => discountPercentage >= 1;

  bool get inStock => stock > 0;
}