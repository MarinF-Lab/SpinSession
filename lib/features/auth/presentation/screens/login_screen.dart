import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'SpinSession',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ingresa para preparar tu operacion.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Contrasena',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  if (authState.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      authState.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Iniciar sesión',
                    isLoading: authState.isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: 'Crear cuenta',
                    onPressed: () => context.go(AppRoutes.register),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa tu email y contraseña')),
      );
      return;
    }

    final success = await ref
        .read(authControllerProvider.notifier)
        .signIn(email: email, password: password);

    if (success && mounted) {
      context.go(AppRoutes.deviceSelection);
    }
  }
}
