import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo/features/profile/domain/entities/user.dart';
import 'package:zybo/features/profile/domain/usecase/get_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc(this.getUser) : super(UserInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("access_token");
        final user = await getUser(token!);

        emit(UserLoaded(user: user));
      } catch (e) {
        log("Error fetching products: $e");
        emit(UserError(message: "Failed to fetch User data"));
      }
    });
  }
}
