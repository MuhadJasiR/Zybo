part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishListLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<dynamic> wishList;
  WishlistLoaded(this.wishList);
}

class WishlistUpdated extends WishlistState {}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
