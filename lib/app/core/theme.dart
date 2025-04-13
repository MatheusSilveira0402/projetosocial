import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFE57373), // Vermelho claro
          onPrimary: Colors.white,
          secondary: Color(0xFFFFB74D), // Laranja suave
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF212121),
          error: Colors.red,
          onError: Colors.white,
          primaryContainer: Color(0xFFFADBD8), // Para botões ou caixas
          onPrimaryContainer: Color(0xFF212121),
          secondaryContainer: Color(0xFFFFECB3), // Laranja suave mais claro
          onSecondaryContainer: Color(0xFF212121),
          inversePrimary: Color(0xFF212121),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F5F2),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 90,
          titleSpacing: 20,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
          backgroundColor: Color(0xFFE57373),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          color: const Color(0xFFFFF8F6), // Fundo rosado leve
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          helperStyle: TextStyle(color: Colors.grey[500]),
          labelStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE57373), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE57373),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF212121),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF212121),
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Color(0xFF757575),
          ),
        ),
      );
}
