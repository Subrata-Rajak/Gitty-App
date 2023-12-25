import 'package:gitty/feature/auth/domain/entities/user_entity.dart';

abstract class RegisterScreenStates {}

class RegisterInitialState extends RegisterScreenStates {}

class RegisterPasswordFieldState extends RegisterScreenStates {
  final bool isObscure;

  RegisterPasswordFieldState({required this.isObscure});
}

class RegisteringState extends RegisterScreenStates {}

class RegisterSuccessfulState extends RegisterScreenStates {
  UserEntity? user;

  RegisterSuccessfulState({required this.user});
}

class RegisterFailedState extends RegisterScreenStates {
  final String errorMessage;

  RegisterFailedState({required this.errorMessage});
}
