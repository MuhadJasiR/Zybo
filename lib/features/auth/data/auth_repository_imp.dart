import 'package:zybo/features/auth/domain/auth_repository.dart';
import 'package:zybo/features/auth/data/auth_remote_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<String> verifyUser(String phoneNumber, {String? firstName}) async {
    return await remoteDataSource.verifyUser(phoneNumber);
  }

  @override
  Future<String> loginOrRegister(String phoneNumber,
      {String? firstName}) async {
    return await remoteDataSource.loginOrRegister(phoneNumber,
        firstName: firstName);
  }
}
