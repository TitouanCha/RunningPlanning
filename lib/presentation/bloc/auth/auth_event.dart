part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


final class Login extends AuthEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
}