import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/connectivity_provider.dart';
import '../../data/repositories/event_repository.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_settings_entity.dart';
import '../../domain/entities/event_status.dart';

class EventState {
  const EventState({
    required this.events,
    this.isLoading = false,
    this.errorMessage,
  });

  EventState.initial() : this(events: const [], isLoading: true);

  final List<EventEntity> events;
  final bool isLoading;
  final String? errorMessage;

  EventState copyWith({
    List<EventEntity>? events,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EventState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class EventController extends StateNotifier<EventState> {
  EventController(this._repo, this._userId)
      : super(EventState.initial()) {
    loadAll();
  }

  final EventRepository _repo;
  final String _userId;
  static const _uuid = Uuid();

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true);
    try {
      final events = await _repo.getAll(_userId);
      state = EventState(events: _applyAutoStatus(events));
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Sincroniza con el backend (empuja pendientes, luego trae remotos) y
  /// recarga la lista local. Solo actúa si hay conexión; en modo Offline
  /// la app sigue funcionando con los datos locales (Anexo A.1.7).
  Future<void> syncWithRemote() async {
    if (_userId.isEmpty) return;
    if (!await hasConnectionNow()) return;
    await _repo.syncPending();
    await _repo.pullFromRemote(_userId);
    await loadAll();
  }

  Future<bool> createEvent({
    required String name,
    required DateTime eventDate,
    required DateTime startDatetime,
    required DateTime endDatetime,
    String? templateId,
    String? notes,
  }) async {
    try {
      final now = DateTime.now();
      final event = EventEntity(
        id: _uuid.v4(),
        userId: _userId,
        name: name,
        eventDate: eventDate,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        eventStatus: EventStatus.reserved,
        paymentStatus: PaymentStatus.pending,
        gallerySlug: _generateSlug(name),
        templateId: templateId,
        notes: notes,
        createdAt: now,
        updatedAt: now,
      );
      await _repo.save(event);
      await loadAll();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> updateEvent(EventEntity event) async {
    try {
      await _repo.save(event.copyWith(updatedAt: DateTime.now()));
      await loadAll();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _repo.delete(id);
      await loadAll();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Genera (o reutiliza) el link de pago de Mercado Pago para este evento
  /// y lo devuelve para que la UI lo abra. El evento NO se marca pagado acá
  /// — eso lo hace el webhook de Mercado Pago al confirmarse el pago real
  /// (ver supabase/functions/mercadopago-webhook), reflejado en la UI vía
  /// Realtime.
  Future<String?> registerPayment(String id) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
        'create-payment-preference',
        body: {'eventId': id},
      );
      final checkoutUrl = (response.data as Map?)?['checkoutUrl'] as String?;
      if (checkoutUrl == null) {
        state = state.copyWith(
            errorMessage: 'No se pudo generar el link de pago.');
        return null;
      }
      await _repo.updatePaymentLink(id, checkoutUrl);
      await loadAll();
      return checkoutUrl;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return null;
    }
  }

  Future<void> cancelPayment(String id) async {
    await _repo.updatePaymentStatus(id, PaymentStatus.pending);
    await _repo.updateStatus(id, EventStatus.pendingPayment);
    await loadAll();
  }

  Future<void> archiveEvent(String id) async {
    await _repo.updateStatus(id, EventStatus.archived);
    await loadAll();
  }

  Future<void> saveSettings(EventSettingsEntity settings) =>
      _repo.saveSettings(settings);

  Future<void> syncPending() => _repo.syncPending();

  List<EventEntity> _applyAutoStatus(List<EventEntity> events) {
    final now = DateTime.now();
    return events.map((e) {
      if (e.eventStatus == EventStatus.paid && now.isAfter(e.startDatetime)) {
        _repo.updateStatus(e.id, EventStatus.active).ignore();
        return e.copyWith(eventStatus: EventStatus.active);
      }
      if (e.eventStatus == EventStatus.active && now.isAfter(e.endDatetime)) {
        _repo.updateStatus(e.id, EventStatus.finished).ignore();
        return e.copyWith(eventStatus: EventStatus.finished);
      }
      return e;
    }).toList();
  }

  String _generateSlug(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '-');
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}
