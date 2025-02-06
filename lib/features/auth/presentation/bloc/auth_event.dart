part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class VerifyUserEvent extends AuthEvent {
  final String phoneNumber;
  VerifyUserEvent(this.phoneNumber);
}

class LoginOrRegisterEvent extends AuthEvent {
  final String phoneNumber;
  final String? firstName;
  LoginOrRegisterEvent(this.firstName, this.phoneNumber);
}
