import 'package:flutter/material.dart';

abstract final class AppColors {
  // Paleta oficial del Design System SpinSession
  static const primary = Color(0xFF8A2BE2); // Morado principal
  static const primaryDark = Color(0xFFB894DF); // Morado secundario
  static const accent = Color(0xFFFF4DDA); // Acento neón
  static const lightBackground = Color(0xFFF7F7F8); // Fondo claro
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkBackground = Color(0xFF121212); // Fondo oscuro
  static const darkSurface = Color(0xFF1A1A1A);
  static const textDark = Color(0xFF0E0E0E); // Texto oscuro
  static const textLight = Color(0xFFEDEDED); // Texto claro
  static const muted = Color(0xFF6F6A7C);
  static const error = Color(0xFFBA1A1A);

  // Colores de estado (etiquetas)
  static const statusReserved = Color(0xFFE91E8C);
  static const statusPaid = Color(0xFF2F80ED);
  static const statusActive = Color(0xFF27AE60);
  static const statusFinished = Color(0xFF9E9E9E);
}
