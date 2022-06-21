// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  AuthFailed(this.message);
}

class AuthProgress extends AuthState {}

class AuthLoginedIn extends AuthState {
  final User user;
  AuthLoginedIn({
    required this.user,
  });
}

class AuthSignedUp extends AuthState {}
