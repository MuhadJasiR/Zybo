part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUserData extends UserEvent {
  final String? token;
  FetchUserData({this.token});
}
