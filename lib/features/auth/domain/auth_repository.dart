abstract class AuthRepository {
  Future<String> verifyUser(String phoneNumber);
  Future<String> loginOrRegister(String phoneNumber, {String? firstName});
}
