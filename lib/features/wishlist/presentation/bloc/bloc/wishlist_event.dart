part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class LoadWishList extends WishlistEvent {
  final String token;
  LoadWishList(this.token);
}

class ToggleWishlist extends WishlistEvent {
  final String productId;
  final String token;
  ToggleWishlist(this.productId, this.token);
}
