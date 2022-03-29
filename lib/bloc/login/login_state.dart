part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final String msg;
  final String token;

  LoginSuccess(this.msg,this.token);
}
class LoginFailure extends LoginState {
  final String msg;

  LoginFailure(this.msg);
}

class LogoutLoading extends LoginState {}
class LogoutSuccess extends LoginState {
  final String msg;

  LogoutSuccess(this.msg);
}
class LogoutFailure extends LoginState {
  final String msg;

  LogoutFailure(this.msg);
}