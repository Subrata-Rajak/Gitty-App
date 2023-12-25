import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitty/feature/auth/domain/usecases/register_usecase.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_events.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_state.dart';

class RegisterBloc extends Bloc<RegisterScreenEvents, RegisterScreenStates> {
  final RegisterUsecase registerUsecase;
  RegisterBloc({required this.registerUsecase})
      : super(RegisterInitialState()) {
    on<ToggleRegisterPasswordFieldEvent>(toggleRegisterPasswordField);
    on<RegisterUserEvent>(registerUser);
  }

  FutureOr<void> toggleRegisterPasswordField(
    ToggleRegisterPasswordFieldEvent event,
    Emitter<RegisterScreenStates> emit,
  ) {
    if (state is RegisterInitialState) {
      emit(RegisterPasswordFieldState(isObscure: false));
    } else {
      final currentState = state as RegisterPasswordFieldState;
      emit(RegisterPasswordFieldState(isObscure: !currentState.isObscure));
    }
  }

  FutureOr<void> registerUser(
    RegisterUserEvent event,
    Emitter<RegisterScreenStates> emit,
  ) async {
    emit(RegisteringState());
    final email = event.email;
    final password = event.password;

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        if (EmailValidator.validate(email) && password.length >= 6) {
          if (password.length >= 6) {
            var res = await registerUsecase.registerUser(
              email: email,
              password: password,
            );

            if (res != null) {
              emit(RegisterSuccessfulState(user: res));
            } else {
              emit(
                RegisterFailedState(
                  errorMessage: "Login Failed! Please Try again",
                ),
              );
            }
          } else {
            emit(RegisterFailedState(
                errorMessage:
                    "Password should have length of at least 6 characters"));
          }
        } else {
          emit(RegisterFailedState(errorMessage: "Enter a valid email"));
        }
      } else {
        emit(RegisterFailedState(errorMessage: "Enter all required fields"));
      }
    } catch (error) {
      print("Error while login user -- Register BLOC");
      emit(RegisterFailedState(errorMessage: "Internal error"));
    }
  }
}
