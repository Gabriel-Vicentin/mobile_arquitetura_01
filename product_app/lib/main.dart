import 'package:flutter/material.dart';
import 'package:product_app/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App - CRUD',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0B5FAE),
          onPrimary: Colors.white,
          secondary: Color(0xFF0F9DA5),
          onSecondary: Colors.white,
          surface: Color(0xFFF0F6FC),
          onSurface: Color(0xFF0E1B2A),
          error: Color(0xFFB3261E),
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFEAF2F9),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFFEAF2F9),
          foregroundColor: Color(0xFF0E1B2A),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0E1B2A),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF0B5FAE),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}
