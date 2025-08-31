
import 'package:flutter/material.dart';
import 'v0_welcome.dart';
import 'card_choice_page.dart';

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
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.orange.shade50,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const V0Welcome(),
        '/card-choice': (context) => const CardChoicePage(),
      },
    );
  }
}
