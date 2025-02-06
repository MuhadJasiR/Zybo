import 'package:zybo/features/profile/data/datasource/user_remote_datasources.dart';
import 'package:zybo/features/profile/domain/entities/user.dart';
import 'package:zybo/features/profile/domain/repo/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;
  UserRepositoryImpl(this.remoteDatasource);
  @override
  Future<User> getUserData(String token) async {
    return await remoteDatasource.getUserData(token);
  }
}
