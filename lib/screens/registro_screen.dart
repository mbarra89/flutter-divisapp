import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegistroScreen extends ConsumerStatefulWidget {
  const RegistroScreen({super.key});

  @override
  ConsumerState<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends ConsumerState<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCompletoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _fechaNacimiento;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _nombreCompletoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  Future<void> _registrar() async {
    // Validar el formulario
    if (!_formKey.currentState!.validate()) return;

    // Validar fecha de nacimiento
    if (_fechaNacimiento == null) {
      setState(() {
        _errorMessage = 'Por favor selecciona tu fecha de nacimiento';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Registro de usuario en Firebase Authentication
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Guardar información adicional del usuario en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nombreCompleto': _nombreCompletoController.text.trim(),
        'email': _emailController.text.trim(),
        'fechaNacimiento': Timestamp.fromDate(_fechaNacimiento!),
        'fechaRegistro': FieldValue.serverTimestamp(),
        'uid': userCredential.user!.uid,
      });

      // Navegar a la pantalla principal después del registro
      if (mounted) {
        context.go('/');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = 'El correo electrónico ya está registrado';
            break;
          case 'weak-password':
            _errorMessage = 'La contraseña es demasiado débil';
            break;
          default:
            _errorMessage = 'Error en el registro: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado: $e';
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
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de Nombre Completo
              TextFormField(
                controller: _nombreCompletoController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  labelStyle: TextStyle(
                    color: isDarkMode
                        ? AppTheme.darkTextColor
                        : AppTheme.lightTextColor,
                  ),
                  prefixIcon: Icon(Icons.person,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu nombre completo';
                  }
                  // Validación para nombres con al menos dos palabras
                  if (!value.trim().contains(' ')) {
                    return 'Ingresa nombre y apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo de Email
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
                  final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Campo de Contraseña
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

              // Selector de Fecha de Nacimiento
              GestureDetector(
                onTap: _seleccionarFecha,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      labelStyle: TextStyle(
                        color: isDarkMode
                            ? AppTheme.darkTextColor
                            : AppTheme.lightTextColor,
                      ),
                      prefixIcon: Icon(Icons.calendar_today,
                          color: isDarkMode
                              ? AppTheme.darkIconColor
                              : AppTheme.lightIconColor),
                      hintText: _fechaNacimiento != null
                          ? '${_fechaNacimiento!.day}/${_fechaNacimiento!.month}/${_fechaNacimiento!.year}'
                          : 'Selecciona tu fecha de nacimiento',
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
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Mensaje de Error
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),

              // Botón de Registro
              ElevatedButton(
                onPressed: _isLoading ? null : _registrar,
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
                    : const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
