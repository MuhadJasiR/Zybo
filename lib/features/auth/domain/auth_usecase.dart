import 'package:zybo/features/auth/domain/auth_repository.dart';

class VerifyUserUseCase {
  final AuthRepository repository;
  VerifyUserUseCase(this.repository);
  Future<String> call(String phoneNumber) {
    return repository.verifyUser(phoneNumber);
  }
}

class LoginOrRegisterUseCase {
  final AuthRepository repository;
  LoginOrRegisterUseCase(this.repository);
  Future<String> call(String phoneNumber, {String? firstName}) {
    return repository.loginOrRegister(phoneNumber, firstName: firstName);
  }
}
