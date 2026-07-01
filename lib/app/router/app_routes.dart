abstract final class AppRoutes {
  // Auth
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const deviceSelection = '/device-selection';

  // Main
  static const home = '/home';
  static const settings = '/settings';
  static const estudioTab = '/estudio';
  static const registroTab = '/registro';

  // Events
  static const calendar = '/calendar';
  static const eventCreate = '/event/create';
  static const history = '/history';
  static String eventDetail(String id) => '/event/$id';
  static String eventEdit(String id) => '/event/$id/edit';

  // Templates
  static const templates = '/templates';
  static const templateCreate = '/templates/create';

  // Studio (Sprint 3)
  static String studio(String eventId) => '/studio/$eventId';
  static String studioConfig(String eventId) => '/studio/$eventId/config';
  static String studioGuest(String eventId) => '/studio/$eventId/guest';
  static String studioSessionConfig(String eventId, String sessionId) =>
      '/studio/$eventId/session-config/$sessionId';
  static String studioRecording(String eventId, String sessionId) =>
      '/studio/$eventId/recording/$sessionId';
  static String studioConfirmation(String eventId, String sessionId) =>
      '/studio/$eventId/confirm/$sessionId';
  static String studioSessions(String eventId) =>
      '/studio/$eventId/sessions';

  // SpinLab (Sprint 3)
  static const spinlab = '/spinlab';

  // Processing (Sprint 4)
  static String processing(String sessionId) => '/processing/$sessionId';

  // Sync / Gallery (Sprint 5)
  static String sync(String sessionId) => '/sync/$sessionId';
  static String gallery(String eventId) => '/gallery/$eventId';
  static String privateSession(String sessionId) => '/private/$sessionId';
}
