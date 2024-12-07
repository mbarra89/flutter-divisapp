import 'package:divisapp/firebase_options.dart';
import 'package:divisapp/providers/economic_indicators_provider.dart';
import 'package:divisapp/providers/theme_provider.dart';
import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

const double kAppBarTotalHeight = kToolbarHeight;

final Logger _logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Añada esta línea
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _logger.i('Firebase initialized');
  } catch (e, s) {
    _logger.e('Error initializing Firebase', error: e, stackTrace: s);
  }

  // Create a ProviderContainer to access providers before running the app
  final container = ProviderContainer();

  try {
    // Initialize economic indicators
    await container.read(initializeEconomicIndicatorsProvider.future);
    _logger.i('Economic indicators initialized');
  } catch (e) {
    _logger.e('Error initializing economic indicators', error: e);
  }

  // Dispose the temporary container
  container.dispose();

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
      theme: ThemeData(fontFamily: 'Roboto', brightness: Brightness.dark),
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
        // appBar: _buildAppBar(context, themeMode),
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
