import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zybo/features/home/data/data_sources/product_remote_data_source.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final ProductRemoteDataSource repository;
  WishlistBloc(this.repository) : super(WishlistInitial()) {
    on<LoadWishList>((event, emit) async {
      emit(WishListLoading());
      try {
        final List<dynamic> wishlist =
            await repository.getWishlist(event.token);
        emit(WishlistLoaded(wishlist));
      } catch (e) {
        log(e.toString(), name: "wishlist Error");
        emit(WishlistError("Failed to load wishlist"));
      }
    });
    on<ToggleWishlist>(
      (event, emit) async {
        try {
          await repository.toggleWishlist(
            event.productId,
            event.token,
          );
          emit(WishlistUpdated());
        } catch (e) {
          log(e.toString(), name: "toggle wishlist Error");
          emit(WishlistError("Failed to update wishlist"));
        }
      },
    );
  }
}
