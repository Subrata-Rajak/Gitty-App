import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitty/feature/auth/domain/usecases/login_usecase.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_events.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_states.dart';

class LoginBloc extends Bloc<LoginScreenEvents, LoginScreenStates> {
  final LoginUsecase loginUsecase;
  LoginBloc({
    required this.loginUsecase,
  }) : super(LoginInitialState()) {
    on<ToggleLoginPasswordObscureEvent>(toggleLoginPasswordObscure);
    on<LoginUserEvent>(loginUser);
  }

  FutureOr<void> toggleLoginPasswordObscure(
    ToggleLoginPasswordObscureEvent event,
    Emitter<LoginScreenStates> emit,
  ) {
    if (state is LoginInitialState) {
      emit(LoginPasswordFieldState(isObscure: false));
    } else {
      final currentState = state as LoginPasswordFieldState;
      emit(LoginPasswordFieldState(isObscure: !currentState.isObscure));
    }
  }

  FutureOr<void> loginUser(
    LoginUserEvent event,
    Emitter<LoginScreenStates> emit,
  ) async {
    emit(LoggingInState());
    final email = event.email;

    try {
      if (email.isNotEmpty) {
        if (EmailValidator.validate(email)) {
          var res = await loginUsecase.loginUser(email: email);

          if (res != null) {
            emit(LoginSuccessfulState(user: res));
          } else {
            emit(
              LoginFailedState(
                errorMessage: "Login Failed! Please Try again",
              ),
            );
          }
        } else {
          emit(LoginFailedState(errorMessage: "Enter a valid email"));
        }
      } else {
        emit(LoginFailedState(errorMessage: "Enter all required fields"));
      }
    } catch (error) {
      print("Error while login user -- Login BLOC: $error");
      emit(LoginFailedState(errorMessage: "Internal error"));
    }
  }
}
