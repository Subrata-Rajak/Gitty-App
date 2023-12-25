abstract class LoginScreenEvents {}

class ToggleLoginPasswordObscureEvent extends LoginScreenEvents {}

class LoginUserEvent extends LoginScreenEvents {
  final String email;

  LoginUserEvent({required this.email});
}
