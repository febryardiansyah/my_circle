part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthAuthenticated extends AuthState {}
class AuthUnAuthenticated extends AuthState {}
