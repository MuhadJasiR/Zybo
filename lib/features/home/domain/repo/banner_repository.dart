import 'package:zybo/features/home/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<List<Banners>> getBanners();
}
