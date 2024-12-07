import 'package:divisapp/providers/theme_provider.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:divisapp/providers/user_provider.dart'; // Asegúrate de importar el provider de usuario

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    // Observar los datos del usuario actual
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () =>
                  ref.read(themeModeNotifierProvider.notifier).toggleTheme(),
            ),
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay usuario autenticado'),
                  ElevatedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Iniciar Sesión'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Foto de perfil
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          user.nombreCompleto[0],
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Información básica
                      Text(
                        user.nombreCompleto,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Miembro desde ${user.fechaRegistro.year}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cake,
                            size: 16,
                            color: AppTheme.darkIconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                              'Nacimiento: ${user.fechaNacimiento.day}/${user.fechaNacimiento.month}/${user.fechaNacimiento.year}'),
                        ],
                      ),

                      // Información de contacto
                      Card(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Información de contacto',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                leading: const Icon(
                                  Icons.email,
                                  color: AppTheme.darkIconColor,
                                ),
                                title: Text(user.email),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Botón de Cerrar Sesión
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton.icon(
                          onPressed: () => ref.read(logoutProvider),
                          icon: const Icon(Icons.logout),
                          label: const Text('Cerrar Sesión'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppTheme.darkTextColor,
                            backgroundColor: AppTheme.errorMessageColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error al cargar el perfil'),
              Text(error.toString()),
              ElevatedButton(
                onPressed: () => ref.invalidate(currentUserProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
