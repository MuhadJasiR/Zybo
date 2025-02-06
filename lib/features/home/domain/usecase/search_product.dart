import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/domain/repo/product_repository.dart';

class SearchProduct {
  final ProductRepository repository;
  SearchProduct(this.repository);
  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
