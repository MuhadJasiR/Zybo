import 'package:zybo/features/home/data/data_sources/banner_remote_data_source.dart';
import 'package:zybo/features/home/domain/entities/banner.dart';
import 'package:zybo/features/home/domain/repo/banner_repository.dart';

class BannerRepositoryImp implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;
  BannerRepositoryImp(this.remoteDataSource);
  @override
  Future<List<Banners>> getBanners() async {
    return await remoteDataSource.getBanner();
  }
}
