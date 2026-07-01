import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spinsession/app/app.dart';
import 'package:spinsession/core/preferences/local_preferences_repository.dart';

void main() {
  setUpAll(() async {
    // AuthController lee Supabase.instance al construirse; sin esto,
    // cualquier widget test que monte SpinSessionApp falla con un
    // assertion error antes de poder renderizar nada. Supabase también
    // usa SharedPreferences internamente, que requiere valores mock
    // en el entorno de test (no hay plugin real disponible).
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://example.supabase.co',
      publishableKey: 'test-anon-key',
    );
  });

  testWidgets('shows the login screen after splash', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localPreferencesRepositoryProvider.overrideWithValue(
            _FakePreferencesRepository(),
          ),
        ],
        child: const SpinSessionApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('SpinSession'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}

class _FakePreferencesRepository extends LocalPreferencesRepository {
  @override
  Future<String?> readDeviceMode() async => null;

  @override
  Future<String?> readThemeMode() async => null;
}
