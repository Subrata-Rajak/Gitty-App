import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/core/routes/route_paths.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_events.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_states.dart';
import 'package:gitty/injection_container.dart';
import 'package:gitty/src/values/colors.dart';
import 'package:gitty/src/values/strings.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CommonWidgets {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // every text editing controller needs to be disposed to prevent memory leakage
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(size),
    );
  }

  SafeArea buildBody(Size size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLoginHeader(),
              verticalSpace(h: 40),
              buildEmailTextInputField(),
              verticalSpace(h: 40),
              buildLoginButton(size: size),
              verticalSpace(h: 20),
              buildRegisterNav(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRegisterNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(AppStrings.instance.registerNavPhrase),
            TextButton(
              onPressed: () {
                context.replace(AppRoutePaths.instance.registerScreenRoutePath);
              },
              child: Text(
                AppStrings.instance.registerButtonText,
              ),
            ),
          ],
        )
      ],
    );
  }

  buildLoginButton({required Size size}) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl(),
      child: BlocConsumer<LoginBloc, LoginScreenStates>(
        listener: (context, state) {
          if (state is LoginSuccessfulState) {
            context.replace(AppRoutePaths.instance.homeScreenRoutePath);
          }
        },
        builder: (context, state) {
          if (state is LoginInitialState || state is LoginFailedState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                        LoginUserEvent(
                          email: emailController.text,
                        ),
                      );

                  if (state is LoginFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.instance.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  AppStrings.instance.loginButtonText,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.instance.white,
                  ),
                ),
              ),
            );
          } else if (state is LoggingInState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.instance.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: CircularProgressIndicator(
                  color: AppColors.instance.white,
                ),
              ),
            );
          }
          return emptyContainer();
        },
      ),
    );
  }

  TextFormField buildEmailTextInputField() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        label: Text("Email"),
        hintText: "john@gmail.com",
      ),
    );
  }

  Column buildLoginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.instance.appName,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.instance.black,
          ),
        ),
        verticalSpace(h: 10),
        Text(
          AppStrings.instance.loginText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.instance.black,
          ),
        ),
        verticalSpace(h: 5),
        Text(
          AppStrings.instance.loginSubText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.instance.grey,
          ),
        ),
      ],
    );
  }
}
