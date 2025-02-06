part of 'banner_bloc.dart';

@immutable
abstract class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerLoaded extends BannerState {
  final List<Banners> banners;
  BannerLoaded(this.banners);
}

final class BannerError extends BannerState {
  final String message;
  BannerError(this.message);
}
