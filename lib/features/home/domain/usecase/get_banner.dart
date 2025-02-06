import 'package:zybo/features/home/domain/entities/banner.dart';
import 'package:zybo/features/home/domain/repo/banner_repository.dart';

class GetBanner {
  final BannerRepository repository;
  GetBanner(this.repository);
  Future<List<Banners>> call() async {
    return await repository.getBanners();
  }
}
