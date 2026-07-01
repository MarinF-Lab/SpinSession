# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# FFmpegKit (JNI / reflection)
-keep class com.antonkarpenko.ffmpegkit.** { *; }
-keep class com.arthenica.ffmpegkit.** { *; }

# CameraX
-keep class androidx.camera.** { *; }

# Supabase / Gotrue / Postgrest (usan serialización por reflexión)
-keep class io.github.jan.supabase.** { *; }
-keepattributes *Annotation*
-keepattributes Signature

# Evita warnings que detienen el build por clases opcionales no usadas
-dontwarn io.flutter.embedding.**
