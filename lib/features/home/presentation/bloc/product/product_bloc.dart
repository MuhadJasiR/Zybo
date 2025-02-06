import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zybo/features/home/domain/entities/product.dart';
import 'package:zybo/features/home/domain/usecase/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProducts fetchProducts;
  ProductBloc(this.fetchProducts) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        log("here");
        final products = await fetchProducts();
        log(products.toString());
        emit(ProductLoaded(products));
      } catch (e) {
        log("Error fetching products: $e");
        emit(ProductError("Failed to Fetch Products"));
      }
    });
  }
}
