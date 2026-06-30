import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final localPreferencesRepositoryProvider = Provider<LocalPreferencesRepository>(
  (ref) {
    return LocalPreferencesRepository();
  },
);

class LocalPreferencesRepository {
  static const _fileName = 'spinsession_preferences.json';
  static const _themeModeKey = 'theme_mode';
  static const _deviceModeKey = 'device_mode';
  static const _deviceIdKey = 'device_id';

  Future<String?> readThemeMode() async {
    final values = await _readValues();
    return values[_themeModeKey] as String?;
  }

  Future<void> saveThemeMode(String value) async {
    await _saveValue(_themeModeKey, value);
  }

  Future<String?> readDeviceMode() async {
    final values = await _readValues();
    return values[_deviceModeKey] as String?;
  }

  Future<void> saveDeviceMode(String value) async {
    await _saveValue(_deviceModeKey, value);
  }

  Future<String?> readDeviceId() async {
    final values = await _readValues();
    return values[_deviceIdKey] as String?;
  }

  Future<void> saveDeviceId(String value) async {
    await _saveValue(_deviceIdKey, value);
  }

  Future<void> _saveValue(String key, String value) async {
    final values = await _readValues();
    values[key] = value;
    await _writeValues(values);
  }

  Future<Map<String, Object?>> _readValues() async {
    final file = await _preferencesFile();

    if (!await file.exists()) {
      return <String, Object?>{};
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return <String, Object?>{};
    }

    final decoded = jsonDecode(content);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return <String, Object?>{};
  }

  Future<void> _writeValues(Map<String, Object?> values) async {
    final file = await _preferencesFile();
    await file.writeAsString(jsonEncode(values));
  }

  Future<File> _preferencesFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}${Platform.pathSeparator}$_fileName');
  }
}
