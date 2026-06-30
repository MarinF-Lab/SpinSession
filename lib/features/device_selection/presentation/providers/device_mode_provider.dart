import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/preferences/local_preferences_repository.dart';
import '../../domain/entities/device_mode.dart';

final deviceModeControllerProvider =
    StateNotifierProvider<DeviceModeController, DeviceModeState>((ref) {
      return DeviceModeController(
        ref.watch(localPreferencesRepositoryProvider),
      );
    });

class DeviceModeController extends StateNotifier<DeviceModeState> {
  DeviceModeController(this._preferencesRepository)
    : super(const DeviceModeState.loading()) {
    loadDeviceMode();
  }

  final LocalPreferencesRepository _preferencesRepository;

  Future<void> loadDeviceMode() async {
    state = const DeviceModeState.loading();
    final savedValue = await _preferencesRepository.readDeviceMode();
    final savedMode = DeviceMode.values.cast<DeviceMode?>().firstWhere(
      (mode) => mode?.name == savedValue,
      orElse: () => null,
    );
    state = DeviceModeState.ready(savedMode);
  }

  Future<void> selectMode(DeviceMode mode) async {
    await _preferencesRepository.saveDeviceMode(mode.name);
    state = DeviceModeState.ready(mode);
  }
}

class DeviceModeState {
  const DeviceModeState({required this.isLoading, this.mode});

  const DeviceModeState.loading() : this(isLoading: true);

  const DeviceModeState.ready(DeviceMode? mode)
    : this(isLoading: false, mode: mode);

  final bool isLoading;
  final DeviceMode? mode;
}
