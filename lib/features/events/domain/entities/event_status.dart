enum EventStatus {
  reserved,
  pendingPayment,
  paid,
  active,
  paused,
  finished,
  archived;

  String get label => switch (this) {
    EventStatus.reserved => 'Reservado',
    EventStatus.pendingPayment => 'Pendiente de pago',
    EventStatus.paid => 'Pagado',
    EventStatus.active => 'Activo',
    EventStatus.paused => 'Pausado',
    EventStatus.finished => 'Finalizado',
    EventStatus.archived => 'Archivado',
  };

  static EventStatus fromString(String value) => switch (value) {
    'pending_payment' => EventStatus.pendingPayment,
    'paid' => EventStatus.paid,
    'active' => EventStatus.active,
    'paused' => EventStatus.paused,
    'finished' => EventStatus.finished,
    'archived' => EventStatus.archived,
    _ => EventStatus.reserved,
  };

  String get value => switch (this) {
    EventStatus.pendingPayment => 'pending_payment',
    _ => name,
  };

  bool get canEdit => this == reserved || this == pendingPayment || this == paid;
  bool get canRecord => this == active;
  bool get canDelete => this == reserved || this == pendingPayment;
}

enum PaymentStatus {
  pending,
  paid;

  String get label => switch (this) {
    PaymentStatus.pending => 'Pendiente',
    PaymentStatus.paid => 'Pagado',
  };

  static PaymentStatus fromString(String value) =>
      value == 'paid' ? PaymentStatus.paid : PaymentStatus.pending;
}
