part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String otp;
  AuthOtpSent(this.otp);
}

class AuthLoggedIn extends AuthState {
  final String otp;
  AuthLoggedIn(this.otp);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
