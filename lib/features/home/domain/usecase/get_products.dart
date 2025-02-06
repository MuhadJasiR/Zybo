import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/domain/repo/product_repository.dart';

class FetchProducts {
  final ProductRepository repository;
  FetchProducts(this.repository);
  Future<List<Product>> call() async {
    return await repository.fetchProducts();
  }
}
