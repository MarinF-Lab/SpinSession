import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository();
});

final currentUserProvider = Provider<String?>((ref) {
  return ref.watch(authControllerProvider).userEmail;
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref.watch(authRepositoryProvider));
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._authRepository) : super(const AuthState.loading()) {
    recoverSession();
  }

  final AuthRepository _authRepository;

  Future<void> recoverSession() async {
    state = const AuthState.loading();
    state = AuthState.authenticated(_authRepository.currentUserEmail);
  }

  Future<bool> signIn({required String email, required String password}) async {
    state = const AuthState.loading();

    try {
      final userEmail = await _authRepository.signIn(
        email: email.trim(),
        password: password,
      );
      state = AuthState.authenticated(userEmail);
      AppLogger.info('Auth', 'Inicio de sesión exitoso');
      return true;
    } catch (error) {
      state = AuthState.error(error.toString());
      AppLogger.warning('Auth', 'Fallo al iniciar sesión');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    try {
      final userEmail = await _authRepository.register(
        email: email.trim(),
        password: password,
      );
      state = AuthState.authenticated(userEmail);
      AppLogger.info('Auth', 'Registro exitoso');
      return true;
    } catch (error) {
      state = AuthState.error(error.toString());
      AppLogger.warning('Auth', 'Fallo al registrar usuario');
      return false;
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    await _authRepository.signOut();
    state = const AuthState.unauthenticated();
    AppLogger.info('Auth', 'Sesión cerrada');
  }
}

class AuthState {
  const AuthState({required this.isLoading, this.userEmail, this.errorMessage});

  const AuthState.loading() : this(isLoading: true);

  const AuthState.unauthenticated() : this(isLoading: false);

  const AuthState.authenticated(String? email)
    : this(isLoading: false, userEmail: email);

  const AuthState.error(String message)
    : this(isLoading: false, errorMessage: message);

  final bool isLoading;
  final String? userEmail;
  final String? errorMessage;

  bool get isAuthenticated => userEmail != null;
}
