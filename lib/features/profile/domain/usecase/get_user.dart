import 'package:zybo/features/profile/domain/entities/user.dart';
import 'package:zybo/features/profile/domain/repo/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);
  Future<User> call(String token) async {
    return await repository.getUserData(token);
  }
}
