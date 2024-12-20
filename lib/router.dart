import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/screens/convert_screen.dart';
import 'package:divisapp/screens/currency_detail_screen.dart';
import 'package:divisapp/screens/currency_screen.dart';
import 'package:divisapp/screens/login_screen.dart';
import 'package:divisapp/screens/registro_screen.dart';
import 'package:divisapp/screens/user_profile_screen.dart';
import 'package:divisapp/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login('/login'),
  registro('/registro'),
  home('/'),
  convert('/convert'),
  profile('/profile'),
  currencyDetail('/currency/:currencyId');

  final String path;
  const AppRoute(this.path);
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.login.path, // Changed to login route
    debugLogDiagnostics: true,
    routes: [
      // Login route outside of ShellRoute
      _buildRoute(
        route: AppRoute.login,
        builder: (context, state) => const LoginScreen(),
      ),
      _buildRoute(
          route: AppRoute.registro,
          builder: (context, state) => const RegistroScreen()),
      // Existing shell route for main app navigation
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: _buildAppRoutes(),
      ),
    ],
  );
});

List<RouteBase> _buildAppRoutes() {
  return [
    _buildRoute(
      route: AppRoute.home,
      builder: (context, state) => const CurrencyScreen(),
    ),
    _buildRoute(
      route: AppRoute.convert,
      builder: (context, state) => const CurrencyConverterScreen(),
    ),
    _buildRoute(
      route: AppRoute.profile,
      builder: (context, state) => const UserProfile(),
    ),
    _buildRoute(
      route: AppRoute.currencyDetail,
      builder: (context, state) => CurrencyDetailScreen(
        currency: state.extra as CurrencyViewModel,
      ),
    ),
  ];
}

GoRoute _buildRoute({
  required AppRoute route,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    path: route.path,
    builder: builder,
  );
}

extension GoRouterExtension on GoRouter {
  void goToRoute(AppRoute route) => go(route.path);
}
