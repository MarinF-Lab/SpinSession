import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/device_selection/presentation/providers/device_mode_provider.dart';
import '../../features/device_selection/presentation/screens/device_selection_screen.dart';
import '../../features/events/presentation/screens/calendar_screen.dart';
import '../../features/events/presentation/screens/create_event_screen.dart';
import '../../features/events/presentation/screens/edit_event_screen.dart';
import '../../features/events/presentation/screens/event_detail_screen.dart';
import '../../features/events/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/gallery/presentation/screens/gallery_screen.dart';
import '../../features/gallery/presentation/screens/private_session_screen.dart';
import '../../features/processing/presentation/screens/processing_screen.dart';
import '../../features/sync/presentation/screens/sync_screen.dart';
import '../../features/recording/presentation/screens/recording_config_screen.dart';
import '../../features/recording/presentation/screens/recording_screen.dart';
import '../../features/sessions/presentation/screens/confirmation_screen.dart';
import '../../features/sessions/presentation/screens/estudio_tab_screen.dart';
import '../../features/sessions/presentation/screens/guest_registration_screen.dart';
import '../../features/sessions/presentation/screens/registro_tab_screen.dart';
import '../../features/sessions/presentation/screens/session_config_screen.dart';
import '../../features/sessions/presentation/screens/sessions_list_screen.dart';
import '../../features/sessions/presentation/screens/studio_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/spinlab/presentation/screens/spinlab_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/templates/presentation/screens/create_template_screen.dart';
import '../../features/templates/presentation/screens/templates_screen.dart';
import 'app_routes.dart';

// Notifica al router cuando el estado de auth o device mode cambia,
// sin recrear el GoRouter completo.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authControllerProvider, (_, _) => notifyListeners());
    _ref.listen(deviceModeControllerProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}

final _routerNotifierProvider = ChangeNotifierProvider<_RouterNotifier>(
  (ref) => _RouterNotifier(ref),
);

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(_routerNotifierProvider);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final deviceModeState = ref.read(deviceModeControllerProvider);

      final isLoading = authState.isLoading || deviceModeState.isLoading;
      if (isLoading) return AppRoutes.splash;

      final isAuthenticated = authState.isAuthenticated;
      final hasDeviceMode = deviceModeState.mode != null;
      final location = state.matchedLocation;

      final publicRoutes = [
        AppRoutes.splash,
        AppRoutes.login,
        AppRoutes.register,
      ];
      final isPublicRoute = publicRoutes.contains(location);

      if (!isAuthenticated) {
        return isPublicRoute ? null : AppRoutes.login;
      }

      if (!hasDeviceMode) {
        return location == AppRoutes.deviceSelection
            ? null
            : AppRoutes.deviceSelection;
      }

      if (isPublicRoute ||
          location == AppRoutes.deviceSelection ||
          location == AppRoutes.home) {
        return AppRoutes.calendar;
      }

      return null;
    },
    routes: [
      // Auth
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, _) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, _) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.deviceSelection,
        builder: (context, _) => const DeviceSelectionScreen(),
      ),

      // Main
      GoRoute(
        path: AppRoutes.home,
        builder: (context, _) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, _) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.estudioTab,
        builder: (context, _) => const EstudioTabScreen(),
      ),
      GoRoute(
        path: AppRoutes.registroTab,
        builder: (context, _) => const RegistroTabScreen(),
      ),

      // Events
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, _) => const CalendarScreen(),
      ),
      GoRoute(
        path: AppRoutes.eventCreate,
        builder: (context, _) => const CreateEventScreen(),
      ),
      GoRoute(
        path: '/event/:id',
        builder: (_, s) =>
            EventDetailScreen(eventId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/event/:id/edit',
        builder: (_, s) =>
            EditEventScreen(eventId: s.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, _) => const HistoryScreen(),
      ),

      // Templates
      GoRoute(
        path: AppRoutes.templates,
        builder: (context, _) => const TemplatesScreen(),
      ),
      GoRoute(
        path: AppRoutes.templateCreate,
        builder: (context, _) => const CreateTemplateScreen(),
      ),

      // Studio
      GoRoute(
        path: '/studio/:eventId',
        builder: (_, s) =>
            StudioScreen(eventId: s.pathParameters['eventId']!),
      ),
      GoRoute(
        path: '/studio/:eventId/config',
        builder: (_, s) =>
            RecordingConfigScreen(eventId: s.pathParameters['eventId']!),
      ),
      GoRoute(
        path: '/studio/:eventId/guest',
        builder: (_, s) =>
            GuestRegistrationScreen(eventId: s.pathParameters['eventId']!),
      ),
      GoRoute(
        path: '/studio/:eventId/session-config/:sessionId',
        builder: (_, s) => SessionConfigScreen(
          eventId: s.pathParameters['eventId']!,
          sessionId: s.pathParameters['sessionId']!,
        ),
      ),
      GoRoute(
        path: '/studio/:eventId/recording/:sessionId',
        builder: (_, s) => RecordingScreen(
          eventId: s.pathParameters['eventId']!,
          sessionId: s.pathParameters['sessionId']!,
        ),
      ),
      GoRoute(
        path: '/studio/:eventId/confirm/:sessionId',
        builder: (_, s) => ConfirmationScreen(
          eventId: s.pathParameters['eventId']!,
          sessionId: s.pathParameters['sessionId']!,
        ),
      ),
      GoRoute(
        path: '/studio/:eventId/sessions',
        builder: (_, s) =>
            SessionsListScreen(eventId: s.pathParameters['eventId']!),
      ),

      // SpinLab
      GoRoute(
        path: AppRoutes.spinlab,
        builder: (context, _) => const SpinLabScreen(),
      ),

      // Processing
      GoRoute(
        path: '/processing/:sessionId',
        builder: (_, s) =>
            ProcessingScreen(sessionId: s.pathParameters['sessionId']!),
      ),

      // Sync
      GoRoute(
        path: '/sync/:sessionId',
        builder: (_, s) =>
            SyncScreen(sessionId: s.pathParameters['sessionId']!),
      ),

      // Gallery
      GoRoute(
        path: '/gallery/:eventId',
        builder: (_, s) =>
            GalleryScreen(eventId: s.pathParameters['eventId']!),
      ),
      GoRoute(
        path: '/private/:sessionId',
        builder: (_, s) =>
            PrivateSessionScreen(sessionId: s.pathParameters['sessionId']!),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
