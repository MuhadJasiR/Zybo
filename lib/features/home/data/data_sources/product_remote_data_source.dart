import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:zybo/core/api/api_config.dart';
import 'package:zybo/features/home/data/model/product_model.dart';
import 'package:zybo/features/home/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProduct();
  Future<List<Product>> getWishlist(final String token);
  Future<void> toggleWishlist(final String productId, final String token);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSourceImp(this.dio);

  @override
  Future<List<ProductModel>> getProduct() async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.getProduct}";
    log(path);
    final response = await dio.get(path);
    log('Response: ${response.toString()}', name: "response");

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to Load Products");
    }
  }

  @override
  Future<List<Product>> getWishlist(String token) async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.wishList}";

    final response = await dio.get(
      path,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    log("${response.data}", name: "getWishlist response");
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else {
      throw Exception("failed to fetch Wishlist");
    }
  }

  @override
  Future<void> toggleWishlist(String productId, String token) async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.addToWishList}";

    final response = await dio.post(
      path,
      data: {"product_id": productId},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    log("${response.data}", name: "toggleWishList response");

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to update wishlist");
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      const path = "${ApiConfig.baseUrl}${ApiConfig.search}";

      final response = await dio.post(path, data: ({"query": query}));

      log("${response.data}", name: "search response");
      if (response.statusCode == 200) {
        return ProductModel.fromJsonList(response.data);
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString(), name: "search error");
      throw Exception("Failed to fetch search results");
    }
  }
}
