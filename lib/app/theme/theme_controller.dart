import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/preferences/local_preferences_repository.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
      return ThemeController(ref.watch(localPreferencesRepositoryProvider));
    });

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController(this._preferencesRepository) : super(ThemeMode.system) {
    _loadThemeMode();
  }

  final LocalPreferencesRepository _preferencesRepository;

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _preferencesRepository.saveThemeMode(mode.name);
  }

  Future<void> _loadThemeMode() async {
    final savedMode = await _preferencesRepository.readThemeMode();
    state = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedMode,
      orElse: () => ThemeMode.system,
    );
  }
}
