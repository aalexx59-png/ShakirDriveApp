import 'package:flutter/material.dart';

// Pages locales
import 'home_page.dart';
import 'card_choice_page.dart';
import 'solo_card_page.dart';
import 'family_card_page.dart';

void main() {
  runApp(const ShakirDriveApp());
}

class ShakirDriveApp extends StatelessWidget {
  const ShakirDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shakir Drive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8B5E3C), // marron doré
        scaffoldBackgroundColor: const Color(0xFFFAF8F6),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xFF3B2A1F),
          displayColor: const Color(0xFF3B2A1F),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/card-choice': (context) => const CardChoicePage(),
        '/solo-card': (context) => const SoloCardPage(),
        '/family-card': (context) => const FamilyCardPage(),
      },
    );
  }
}
