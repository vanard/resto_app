import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFD32F2F),
    secondary: const Color(0xFFFBC02D),
    tertiary: const Color(0xFF5D4037),
    surface: const Color(0xFFFFFBFF),
    onSurface: const Color(0xFF1E1B16),
    surfaceContainer: const Color(0xFFF5DED6),
    surfaceContainerHigh: const Color(0xFFEFD5CC),
    surfaceContainerHighest: const Color(0xFFE9CDC2),
  ),
  // Component overrides
  appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
  cardTheme: CardThemeData(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFD32F2F),
    brightness: Brightness.dark,
    secondary: const Color(0xFFFFC107),
    tertiary: const Color(0xFFD7CCC8),
    surface: const Color(0xFF1E1B16),
    onSurface: const Color(0xFFE8E1DB),
    surfaceContainer: const Color(0xFF332D28),
    surfaceContainerHigh: const Color(0xFF3D3630),
    surfaceContainerHighest: const Color(0xFF484038),
  ),
  // Dark-specific component overrides
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.grey[900],
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 2,
  ),
);
