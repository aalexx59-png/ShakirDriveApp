import 'package:flutter/material.dart';
import 'home_page.dart';
import 'card_choice_page.dart';
import 'solo_card_page.dart';
import 'family_card_page.dart';
import 'meal_history_section.dart';

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
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/card-choice': (context) => const CardChoicePage(),
        '/solo-card': (context) => const SoloCardPage(),
        '/family-card': (context) => const FamilyCardPage(),
        '/meal-history': (context) => const MealHistorySection(),
      },
    );
  }
}
