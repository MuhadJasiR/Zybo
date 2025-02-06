import 'package:dio/dio.dart';
import 'package:zybo/core/api/api_config.dart';

import 'package:zybo/features/home/domain/entities/banner.dart';

abstract class BannerRemoteDataSource {
  Future<List<Banners>> getBanner();
}

class BannerRemoteDateSourceImpl implements BannerRemoteDataSource {
  final Dio dio;
  BannerRemoteDateSourceImpl(this.dio);
  @override
  Future<List<Banners>> getBanner() async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.getBanner}";
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final List<dynamic> data = await response.data;
      return data.map((json) => Banners.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load Banners");
    }
  }
}
