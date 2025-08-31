import 'package:flutter/material.dart';
import 'v0_welcome.dart';
import 'v1_home.dart';
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
        '/': (context) => const SplashScreen(), // nouvel écran temporaire
        '/welcome': (context) => const V0Welcome(),
        '/home': (context) => const V1Home(),
        '/card-choice': (context) => const CardChoicePage(),
      },
    );
  }
}

/// SplashScreen qui redirige après 3 secondes
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const V0Welcome(); // affiche ton écran V0 pendant 3s
  }
}
