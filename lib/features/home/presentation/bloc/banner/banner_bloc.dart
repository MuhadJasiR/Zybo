import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zybo/features/home/domain/entities/banner.dart';
import 'package:zybo/features/home/domain/usecase/get_banner.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanner getBanner;
  BannerBloc(this.getBanner) : super(BannerInitial()) {
    on<FetchBanner>((event, emit) async {
      emit(BannerLoading());
      try {
        final banners = await getBanner();
        emit(BannerLoaded(banners));
      } catch (e) {
        log("Error fetching Banner: $e");
        emit(BannerError("Failed to Fetch Products"));
      }
    });
  }
}
