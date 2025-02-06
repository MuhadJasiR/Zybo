import 'package:zybo/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/domain/repo/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImp(this.remoteDataSource);
  @override
  Future<List<Product>> fetchProducts() async {
    return await remoteDataSource.getProduct();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return await remoteDataSource.searchProducts(query);
  }
}
