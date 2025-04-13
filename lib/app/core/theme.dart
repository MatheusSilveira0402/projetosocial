import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFE57373), // vermelho claro
          onPrimary: Colors.white,
          secondary: Color(0xFFFFB74D), // laranja suave
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          onSurfaceVariant: Color(0xFFFFF8F6), // bege rosado
          onInverseSurface: Color(0xFF212121), // texto principal
          surface: Colors.white,
          onSurface: Color(0xFF212121),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE57373),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.amber,
          helperStyle: TextStyle(color: Color(0xFFE57373)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE57373),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF212121),
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            color: Color(0xFF212121),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF212121),
          ),
        ),
      );
}
