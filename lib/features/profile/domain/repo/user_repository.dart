import 'package:zybo/features/auth/domain/user.dart';
import 'package:zybo/features/profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserData(String token);
}
