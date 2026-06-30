enum DeviceMode {
  camera,
  operator,
  both;

  String get label {
    return switch (this) {
      DeviceMode.camera => 'Camera',
      DeviceMode.operator => 'Operator',
      DeviceMode.both => 'Both',
    };
  }

  String get description {
    return switch (this) {
      DeviceMode.camera => 'Solo grabacion y procesamiento.',
      DeviceMode.operator => 'Administracion y control del evento.',
      DeviceMode.both => 'Operacion completa en este dispositivo.',
    };
  }
}
