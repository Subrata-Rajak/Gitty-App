import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/core/routes/route_paths.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_bloc.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_events.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_state.dart';
import 'package:gitty/injection_container.dart';
import 'package:gitty/src/values/colors.dart';
import 'package:gitty/src/values/strings.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with CommonWidgets {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
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
              buildRegisterHeader(),
              verticalSpace(h: 40),
              buildEmailTextInputField(),
              verticalSpace(h: 10),
              buildPasswordTextField(),
              verticalSpace(h: 40),
              buildRegisterButton(size: size),
              verticalSpace(h: 20),
              buildLoginNav()
            ],
          ),
        ),
      ),
    );
  }

  Row buildLoginNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(AppStrings.instance.loginNavPhrase),
            TextButton(
              onPressed: () {
                context.replace(AppRoutePaths.instance.loginScreenRoutePath);
              },
              child: Text(
                AppStrings.instance.loginButtonText,
              ),
            ),
          ],
        )
      ],
    );
  }

  buildRegisterButton({required Size size}) {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocConsumer<RegisterBloc, RegisterScreenStates>(
        listener: (context, state) {
          if (state is RegisterSuccessfulState) {
            context.replace(AppRoutePaths.instance.homeScreenRoutePath);
          }
        },
        builder: (context, state) {
          if (state is RegisterInitialState || state is RegisterFailedState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (state is RegisterFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }

                  context.read<RegisterBloc>().add(
                        RegisterUserEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.instance.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  AppStrings.instance.registerButtonText,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.instance.white,
                  ),
                ),
              ),
            );
          } else if (state is RegisteringState) {
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

  BlocProvider<RegisterBloc> buildPasswordTextField() {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocBuilder<RegisterBloc, RegisterScreenStates>(
        builder: (context, state) {
          if (state is RegisterInitialState) {
            return TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(ToggleRegisterPasswordFieldEvent());
                  },
                  child: Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: AppColors.instance.black,
                  ),
                ),
              ),
              obscureText: true,
            );
          } else if (state is RegisterPasswordFieldState) {
            return TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(ToggleRegisterPasswordFieldEvent());
                  },
                  child: Icon(
                    state.isObscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: AppColors.instance.black,
                  ),
                ),
              ),
              obscureText: state.isObscure,
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

  Column buildRegisterHeader() {
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
          AppStrings.instance.registerText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.instance.black,
          ),
        ),
        verticalSpace(h: 5),
        Text(
          AppStrings.instance.registerSubText,
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
