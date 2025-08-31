import 'package:flutter/material.dart';

// Tes écrans (tous dans lib/)
import 'v0_welcome.dart';
import 'v1_home.dart';
import 'v1bis_home.dart';
import 'v2_account.dart';
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
        '/': (context) => const SplashScreen(),     // Affiche V0 pendant 3s
        '/welcome': (context) => const V0Welcome(), // (optionnel si tu veux y revenir)
        '/home': (context) => const V1Home(),       // Accueil (numéro + bouton)
        '/home-bis': (context) => const V1BisHome(),// Profil + tirage
        '/account': (context) => const V2Account(), // Mon compte (historique + paiements)
        '/card-choice': (context) => const CardChoicePage(), // Offres / recharges
      },
    );
  }
}

/// SplashScreen : montre V0Welcome puis redirige vers V1 après 3s.
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
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home'); // → V1 (pas de transition V1→V1BIS)
    });
  }

  @override
  Widget build(BuildContext context) {
    // On réutilise directement ton écran V0 comme “splash”
    return const V0Welcome();
  }
}
