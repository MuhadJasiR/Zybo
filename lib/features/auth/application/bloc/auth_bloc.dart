import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:zybo/features/auth/domain/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerifyUserUseCase verifyUserUseCase;
  final LoginOrRegisterUseCase loginOrRegisterUseCase;
  AuthBloc(
      {required this.verifyUserUseCase, required this.loginOrRegisterUseCase})
      : super(AuthInitial()) {
    on<VerifyUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final otp = await verifyUserUseCase.call(event.phoneNumber);
        log(otp, name: "bloc otp response");
        emit(AuthOtpSent(otp));
      } catch (e) {
        log("$e", name: "error");
        emit(AuthError("failed to verify user"));
      }
    });
    on<LoginOrRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await loginOrRegisterUseCase.call(event.phoneNumber,
            firstName: event.firstName);
        log(token, name: "bloc token response");
        emit(AuthLoggedIn(token));
      } catch (e) {
        log("$e", name: "error message");
        emit(AuthError("Failed to Login/Register"));
      }
    });
  }
}
