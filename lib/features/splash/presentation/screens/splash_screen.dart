import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../device_selection/presentation/providers/device_mode_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final deviceModeState = ref.watch(deviceModeControllerProvider);

    if (!authState.isLoading && !deviceModeState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) {
          return;
        }

        if (!authState.isAuthenticated) {
          context.go(AppRoutes.login);
        } else if (deviceModeState.mode == null) {
          context.go(AppRoutes.deviceSelection);
        } else {
          context.go(AppRoutes.home);
        }
      });
    }

    return const Scaffold(body: LoadingIndicator());
  }
}
