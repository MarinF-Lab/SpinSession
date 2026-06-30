import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/supabase_config.dart';
import 'core/logging/app_logger.dart';
import 'shared/widgets/app_error_widget.dart';

Future<void> main() async {
  runZonedGuarded(_bootstrap, (error, stack) {
    AppLogger.error('Zone', 'Excepción no capturada', error);
  });
}

Future<void> _bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    AppLogger.error('Flutter', details.summary.toString(), details.exception);
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (details) => AppErrorWidget(
        message: kDebugMode ? details.exceptionAsString() : null,
      );

  await initializeDateFormatting('es');

  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.anonKey,
    );
  }

  runApp(const ProviderScope(child: SpinSessionApp()));
}
