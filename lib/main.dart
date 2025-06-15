import 'package:comfort_zone_remake/screens/home_affirmation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color seedColor = Color.fromARGB(255, 64, 35, 193);

    final lightColors = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: seedColor,
    );

    final darkColors = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: seedColor,
    );

    final lightTheme = ThemeData(
      colorScheme: lightColors,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColors.primary,
        foregroundColor: lightColors.onPrimary,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 20.0,
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
        ),
      ),
      useMaterial3: true,
    );

    final darkTheme = ThemeData(
      colorScheme: darkColors,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColors.primary,
        foregroundColor: darkColors.onPrimary,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 20.0,
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
        ),
      ),
      useMaterial3: true,
    );

    return ProviderScope(
      child: MaterialApp(
        title: 'Comfort Zone',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeAffirmationScreen(),
      ),
    );
  }
}
