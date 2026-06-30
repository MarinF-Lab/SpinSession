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
      DeviceMode.camera => 'Solo grabación y procesamiento.',
      DeviceMode.operator => 'Administración y control del evento.',
      DeviceMode.both => 'Operación completa en este dispositivo.',
    };
  }
}
