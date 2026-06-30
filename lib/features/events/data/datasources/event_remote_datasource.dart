import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/supabase_config.dart';
import '../../domain/entities/event_entity.dart';
import '../models/event_model.dart';

class EventRemoteDatasource {
  SupabaseClient get _client => Supabase.instance.client;

  static const _table = 'events';

  Future<void> upsert(EventEntity event) async {
    if (!SupabaseConfig.isConfigured) return;
    await _client.from(_table).upsert(EventModel.toSupabaseMap(event));
  }

  Future<void> delete(String id) async {
    if (!SupabaseConfig.isConfigured) return;
    await _client.from(_table).delete().eq('id', id);
  }

  Future<List<EventEntity>> getAll(String userId) async {
    if (!SupabaseConfig.isConfigured) return [];
    final data = await _client
        .from(_table)
        .select()
        .eq('user_id', userId)
        .order('start_datetime');
    return (data as List)
        .map((e) => EventModel.fromSupabaseMap(e as Map<String, dynamic>))
        .toList();
  }
}
