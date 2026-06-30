abstract final class SupabaseConfig {
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://oqizdogjktxvebqlputj.supabase.co',
  );
  static const anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xaXpkb2dqa3R4dmVicWxwdXRqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI3ODI3NTAsImV4cCI6MjA5ODM1ODc1MH0.trrFileHKzVEhY9S2uQni0aIMrsLAUaXwMC1dcOzDY8',
  );

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}
