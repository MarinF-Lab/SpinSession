import 'dart:collection';

import 'package:flutter/foundation.dart';

enum LogLevel { info, warning, error }

class LogEntry {
  const LogEntry({
    required this.level,
    required this.tag,
    required this.message,
    required this.timestamp,
    this.error,
  });

  final LogLevel level;
  final String tag;
  final String message;
  final DateTime timestamp;
  final Object? error;

  @override
  String toString() =>
      '[${timestamp.toIso8601String()}] ${level.name.toUpperCase()} '
      '($tag): $message${error != null ? ' — $error' : ''}';
}

/// Registro centralizado de eventos de la aplicación.
///
/// Mantiene un buffer circular en memoria (sin datos sensibles) y
/// escribe a la consola en modo debug. No persiste a disco ni remoto:
/// eso pertenece a un Sprint posterior si se requiere.
class AppLogger {
  AppLogger._();

  static const int _maxEntries = 200;
  static final Queue<LogEntry> _buffer = ListQueue<LogEntry>(_maxEntries);

  static List<LogEntry> get recent => List.unmodifiable(_buffer);

  static void info(String tag, String message) =>
      _log(LogLevel.info, tag, message);

  static void warning(String tag, String message) =>
      _log(LogLevel.warning, tag, message);

  static void error(String tag, String message, [Object? error]) =>
      _log(LogLevel.error, tag, message, error);

  static void _log(
    LogLevel level,
    String tag,
    String message, [
    Object? error,
  ]) {
    final entry = LogEntry(
      level: level,
      tag: tag,
      message: message,
      timestamp: DateTime.now(),
      error: error,
    );

    if (_buffer.length >= _maxEntries) {
      _buffer.removeFirst();
    }
    _buffer.add(entry);

    if (kDebugMode) {
      debugPrint(entry.toString());
    }
  }
}
