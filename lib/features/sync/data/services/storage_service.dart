import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  StorageService(this._client);

  final SupabaseClient _client;
  static const _bucket = 'spinsession';

  Future<String> uploadFile(String localPath, String remotePath) async {
    final file = File(localPath);
    await _client.storage.from(_bucket).upload(
          remotePath,
          file,
          fileOptions: const FileOptions(upsert: true),
        );
    return remotePath;
  }

  Future<String> createSignedUrl(
    String remotePath, {
    int expiresInSeconds = 604800, // 7 días
  }) async {
    return await _client.storage
        .from(_bucket)
        .createSignedUrl(remotePath, expiresInSeconds);
  }

  Future<void> deleteFile(String remotePath) async {
    await _client.storage.from(_bucket).remove([remotePath]);
  }

  String buildRemotePath(String sessionId, int takeNumber, String fileName) =>
      'sessions/$sessionId/$takeNumber/$fileName';
}
