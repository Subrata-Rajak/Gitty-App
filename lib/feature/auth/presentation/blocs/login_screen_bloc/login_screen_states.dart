import 'package:gitty/feature/auth/domain/entities/user_entity.dart';

abstract class LoginScreenStates {}

class LoginInitialState extends LoginScreenStates {}

class LoginPasswordFieldState extends LoginScreenStates {
  final bool isObscure;
  LoginPasswordFieldState({required this.isObscure});
}

class LoggingInState extends LoginScreenStates {}

class LoginSuccessfulState extends LoginScreenStates {
  UserEntity? user;

  LoginSuccessfulState({required this.user});
}

class LoginFailedState extends LoginScreenStates {
  final String errorMessage;

  LoginFailedState({required this.errorMessage});
}
