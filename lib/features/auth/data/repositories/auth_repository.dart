import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/supabase_config.dart';
import '../../../../core/errors/app_failure.dart';

abstract interface class AuthRepository {
  String? get currentUserEmail;

  Future<String> signIn({required String email, required String password});

  Future<String> register({required String email, required String password});

  Future<void> signOut();
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  String? get currentUserEmail {
    if (!SupabaseConfig.isConfigured) {
      return null;
    }

    return _client.auth.currentUser?.email;
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    _ensureSupabaseConfigured();

    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final userEmail = response.user?.email;
    if (userEmail == null) {
      throw const AppFailure('No fue posible iniciar sesion.');
    }

    return userEmail;
  }

  @override
  Future<String> register({
    required String email,
    required String password,
  }) async {
    _ensureSupabaseConfigured();

    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final userEmail = response.user?.email;
    if (userEmail == null) {
      throw const AppFailure('No fue posible crear la cuenta.');
    }

    return userEmail;
  }

  @override
  Future<void> signOut() async {
    if (!SupabaseConfig.isConfigured) {
      return;
    }

    await _client.auth.signOut();
  }

  void _ensureSupabaseConfigured() {
    if (!SupabaseConfig.isConfigured) {
      throw const AppFailure(
        'Configura SUPABASE_URL y SUPABASE_ANON_KEY para usar autenticacion.',
      );
    }
  }
}
