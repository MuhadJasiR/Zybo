import 'package:zybo/features/home/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
  Future<List<Product>> searchProducts(String query);
}
