// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gitty/core/local_storage/keys.dart';
import 'package:gitty/core/local_storage/storage.dart';
import 'package:gitty/core/routes/route_paths.dart';
import 'package:gitty/src/values/colors.dart';
import 'package:gitty/src/values/strings.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4000), () async {
      bool? isUserLoggedIn = await LocalStorage.instance
          .readBoolFromLocalDb(key: AppLocalStorageKeys.instance.isLoggedIn);

      if (isUserLoggedIn != null) {
        if (isUserLoggedIn) {
          context.replace(AppRoutePaths.instance.homeScreenRoutePath);
        } else {
          context.replace(AppRoutePaths.instance.loginScreenRoutePath);
        }
      } else {
        context.replace(AppRoutePaths.instance.loginScreenRoutePath);
      }
    });
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.instance.appName,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.instance.black,
          ),
        ),
      ),
    );
  }
}
