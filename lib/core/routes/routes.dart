import 'package:gitty/core/routes/route_names.dart';
import 'package:gitty/core/routes/route_paths.dart';
import 'package:gitty/feature/auth/presentation/views/login_screen.dart';
import 'package:gitty/feature/auth/presentation/views/register_screen.dart';
import 'package:gitty/feature/home/presentation/views/home_screen.dart';
import 'package:gitty/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static AppRoutes instance = AppRoutes();

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePaths.instance.splashScreenRoutePath,
        name: AppRouteNames.instance.splashScreenRouteName,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.loginScreenRoutePath,
        name: AppRouteNames.instance.loginScreenRouteName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.registerScreenRoutePath,
        name: AppRouteNames.instance.registerScreenRouteName,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.instance.homeScreenRoutePath,
        name: AppRouteNames.instance.homeScreenRouteName,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
    initialLocation: AppRoutePaths.instance.splashScreenRoutePath,
  );
}
