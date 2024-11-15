import 'package:divisapp/providers/theme_provider.dart';
import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double kAppBarTotalHeight = kToolbarHeight;

void main() {
  runApp(const ProviderScope(child: DivisApp()));
}

class DivisApp extends ConsumerWidget {
  const DivisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DivisApp',
      // theme: AppTheme.lightTheme(),
      theme: AppTheme.darkTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) =>
          _buildAppStructure(context, child!, themeMode),
    );
  }

  Widget _buildAppStructure(
      BuildContext context, Widget child, ThemeMode themeMode) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _getStatusBarStyle(themeMode),
      child: Scaffold(
        appBar: _buildAppBar(context, themeMode),
        body: child,
      ),
    );
  }

  SystemUiOverlayStyle _getStatusBarStyle(ThemeMode themeMode) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
    );
  }

  PreferredSize _buildAppBar(BuildContext context, ThemeMode themeMode) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top),
      child: AppBar(
        backgroundColor: themeMode == ThemeMode.dark
            ? AppTheme.darkSurfaceColor
            : AppTheme.lightSurfaceColor,
        elevation: 0,
        flexibleSpace: _buildFlexibleSpace(),
      ),
    );
  }

  Widget _buildFlexibleSpace() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/banner.webp',
            fit: BoxFit.cover,
            color: Colors.blue.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ],
    );
  }
}

class ThemeToggleIcon extends ConsumerWidget {
  final ThemeMode themeMode;

  const ThemeToggleIcon({
    super.key,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
        color: Colors.white,
      ),
      onPressed: () =>
          ref.read(themeModeNotifierProvider.notifier).toggleTheme(),
    );
  }
}
