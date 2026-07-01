-- SpinSession — Esquema de base de datos remota (Supabase)
--
-- Este script crea las tablas que la app espera encontrar en Supabase.
-- Sin estas tablas, toda la sincronización local -> remoto y remoto -> local
-- falla en silencio (Offline First: la app sigue funcionando localmente,
-- pero nunca comparte datos entre dispositivos).
--
-- Cómo ejecutarlo:
-- 1. Entra al dashboard de tu proyecto en https://supabase.com
-- 2. Ve a "SQL Editor" (menú lateral)
-- 3. Pega este script completo y presiona "Run"
-- 4. Ve a "Storage" y confirma que el bucket "spinsession" se haya creado
--    (o créalo manualmente como bucket privado si el script no lo permite)

-- ============================================================
-- Tabla: events
-- ============================================================
create table if not exists public.events (
  id text primary key,
  user_id text not null,
  template_id text,
  name text not null,
  event_date timestamptz not null,
  start_datetime timestamptz not null,
  end_datetime timestamptz not null,
  event_status text not null,
  payment_status text not null,
  gallery_slug text not null,
  notes text,
  created_at timestamptz not null,
  updated_at timestamptz not null
);

alter table public.events enable row level security;

drop policy if exists "events_owner_all" on public.events;
create policy "events_owner_all" on public.events
  for all
  using (user_id = auth.jwt() ->> 'email')
  with check (user_id = auth.jwt() ->> 'email');

-- ============================================================
-- Tabla: sessions
-- ============================================================
create table if not exists public.sessions (
  id text primary key,
  event_id text not null,
  guest_name text,
  phone text,
  country_code text,
  notes text,
  device_id text,
  status text,
  created_at timestamptz
);

alter table public.sessions enable row level security;

-- Nota: sessions no guarda user_id directamente; se permite acceso a
-- cualquier usuario autenticado. Si necesitas aislar por dueño del evento,
-- añade user_id a esta tabla y ajusta esta política más adelante.
drop policy if exists "sessions_authenticated_all" on public.sessions;
create policy "sessions_authenticated_all" on public.sessions
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

-- ============================================================
-- Tabla: session_assets
-- ============================================================
create table if not exists public.session_assets (
  id text primary key,
  session_id text not null,
  local_path text,
  remote_path text,
  asset_type text,
  take_number integer
);

alter table public.session_assets enable row level security;

drop policy if exists "session_assets_authenticated_all" on public.session_assets;
create policy "session_assets_authenticated_all" on public.session_assets
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

-- ============================================================
-- Storage bucket: spinsession
-- ============================================================
insert into storage.buckets (id, name, public)
values ('spinsession', 'spinsession', false)
on conflict (id) do nothing;

drop policy if exists "spinsession_authenticated_all" on storage.objects;
create policy "spinsession_authenticated_all"
  on storage.objects
  for all
  using (bucket_id = 'spinsession' and auth.role() = 'authenticated')
  with check (bucket_id = 'spinsession' and auth.role() = 'authenticated');
