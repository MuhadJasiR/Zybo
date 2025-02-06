import 'package:zybo/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.oldPrice,
    required super.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? "Not Mentioned",
      imageUrl: json['images'] ??
          "https://www.svgrepo.com/show/508699/landscape-placeholder.svg",
      price: json['sale_price'],
      oldPrice: json['mrp'],
      rating: json['tax_rate'],
    );
  }
  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
