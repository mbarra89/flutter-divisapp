import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Validate form before attempting login
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Authenticate with Firebase without storing the credentials
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to home screen only after successful authentication
      if (mounted) {
        context.go(AppRoute.home.path);
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = 'No se encontró un usuario con este correo.';
            break;
          case 'wrong-password':
            _errorMessage = 'Contraseña incorrecta.';
            break;
          case 'invalid-email':
            _errorMessage = 'Correo electrónico inválido.';
            break;
          case 'invalid-credential':
            _errorMessage = 'Credenciales inválidas. Verifica tus datos.';
            break;
          default:
            _errorMessage = 'Error de inicio de sesión. Intenta de nuevo.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppTheme.darkTitleTextColor
                          : AppTheme.lightTitleTextColor),
                ),
                const SizedBox(height: 30),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    labelStyle: TextStyle(
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.lightTextColor,
                    ),
                    prefixIcon: Icon(Icons.email,
                        color: isDarkMode
                            ? AppTheme.darkIconColor
                            : AppTheme.lightIconColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppTheme.darkBorderColor
                                : AppTheme.lightBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppTheme.darkBorderColor
                                : AppTheme.lightBorderColor)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo';
                    }
                    // Basic email validation
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password TextField
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.lightTextColor,
                    ),
                    prefixIcon: Icon(Icons.lock,
                        color: isDarkMode
                            ? AppTheme.darkIconColor
                            : AppTheme.lightIconColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppTheme.darkBorderColor
                                : AppTheme.lightBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppTheme.darkBorderColor
                                : AppTheme.lightBorderColor)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Error Message Display
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: AppTheme.errorMessageColor,
                        fontSize: 14,
                      ),
                    ),
                  ),

                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: isDarkMode
                        ? AppTheme.accentGoldColor
                        : AppTheme.accentGoldColor,
                    foregroundColor: isDarkMode
                        ? AppTheme.accentButtonTextColor
                        : AppTheme.accentButtonTextColor,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Iniciar Sesión'),
                ),

                // Optional: Forgot Password and Sign Up Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password navigation
                        // context.push(AppRoute.forgotPassword.path);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: isDarkMode
                            ? AppTheme.alertButtonTextColor
                            : AppTheme.accentGoldColor,
                      ),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(AppRoute.registro.path);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: isDarkMode
                            ? AppTheme.accentGoldColor
                            : AppTheme.accentGoldColor,
                      ),
                      child: const Text('Registrarse'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
