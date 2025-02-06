import 'package:dio/dio.dart';
import 'package:zybo/core/api/api_config.dart';
import 'package:zybo/features/profile/domain/entities/user.dart';

abstract class UserRemoteDatasource {
  Future<User> getUserData(String token);
}

class UserRemoteDatasourcesImpl implements UserRemoteDatasource {
  final Dio dio;
  UserRemoteDatasourcesImpl(this.dio);
  @override
  Future<User> getUserData(String token) async {
    const path = "${ApiConfig.baseUrl}${ApiConfig.getUser}";
    final response = await dio.get(path,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
