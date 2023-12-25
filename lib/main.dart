import 'package:flutter/material.dart';
import 'package:gitty/core/routes/routes.dart';
import 'package:gitty/injection_container.dart';
import 'package:gitty/src/themes/light.dart';

void main() async {
  await initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppLightTheme.instance.getLightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.instance.router,
    );
  }
}
