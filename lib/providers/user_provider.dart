import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divisapp/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'user_provider.g.dart';

// Instancia global de Logger
final logger = Logger();

// Modelo de datos de usuario
class UserModel {
  final String uid;
  final String nombreCompleto;
  final String email;
  final DateTime fechaNacimiento;
  final DateTime fechaRegistro;

  UserModel({
    required this.uid,
    required this.nombreCompleto,
    required this.email,
    required this.fechaNacimiento,
    required this.fechaRegistro,
  });

  // Constructor factory para convertir desde un documento de Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      nombreCompleto: data['nombreCompleto'],
      email: data['email'],
      fechaNacimiento: (data['fechaNacimiento'] as Timestamp).toDate(),
      fechaRegistro: (data['fechaRegistro'] as Timestamp).toDate(),
    );
  }
}

// Provider para obtener los datos del usuario actual
@riverpod
Future<UserModel?> currentUser(Ref ref) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      logger.i('No user currently logged in');
      return null;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      final userData = UserModel.fromFirestore(userDoc);
      logger.i('User data retrieved successfully: ${userData.nombreCompleto}');
      return userData;
    } else {
      logger.w('User document not found for UID: ${user.uid}');
      return null;
    }
  } catch (e) {
    logger.e('Error fetching user data: $e');
    throw Exception('Failed to retrieve user data');
  }
}

// Provider para verificar si hay un usuario autenticado
@riverpod
bool isAuthenticated(Ref ref) {
  final AsyncValue<UserModel?> userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
      data: (user) => user != null,
      loading: () => false,
      error: (_, __) => false);
}

// Provider para cerrar sesión
@riverpod
Future<void> logout(Ref ref) async {
  try {
    // Sign out from Firebase Authentication
    await FirebaseAuth.instance.signOut();
    logger.i('User logged out successfully');

    // Navigate to login screen using the AppRoute enum and extension method
    ref.read(routerProvider).goToRoute(AppRoute.login);
  } catch (e) {
    logger.e('Error during logout: $e');
    throw Exception('Failed to log out');
  }
}
