import 'package:flutter/material.dart';

// === Écrans (tous dans lib/) ===
import 'v0_welcome.dart';              // V0 : Bienvenue + QR (visuel d'accueil)
import 'v1_home.dart';                 // V1 : Accueil (numéro + boutons)
import 'v1bis_home.dart';              // V1 BIS : Profil + tirage hebdo
import 'v2_account.dart';              // V2 : Mon compte (historique + paiements)
import 'v3_balance.dart';              // V3 : Solde + dernier paiement (option écran dédié)
import 'v4_fun_game.dart';             // V4 : Mini-jeu + bandeau “JOUER…”
import 'v5_feedback.dart';             // V5 : Satisfaction (3 smileys)
import 'v6_offers_page.dart';          // V6 : Offres Drive (3 plats + suppléments)
import 'v7_special_promos_page.dart';  // V7 : Promotions spéciales (Anniv / Fêtes / Ramadan)
import 'v8_week_winner_page.dart';     // V8 : Gagnant de la semaine
import 'v_qr_pay.dart';                // QR à montrer au Drive pour payer via solde

// Recharges / Offres (si déjà créés)
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
    const sable = Color(0xFF8B5E3C);

    return MaterialApp(
      title: 'Shakir Drive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF8E6C8), // beige/sable doux
        appBarTheme: const AppBarTheme(
          backgroundColor: sable,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: false,
      ),

      // Point d’entrée : Splash qui affiche V0 pendant 3s puis va vers V1
      initialRoute: '/',

      routes: {
        // Splash intégré dans ce fichier (voir classe en bas)
        '/': (context) => const SplashScreen(),

        // V0 → V8
        '/welcome'       : (context) => const V0Welcome(),
        '/home'          : (context) => const V1Home(),
        '/home-bis'      : (context) => const V1BisHome(),
        '/account'       : (context) => const V2Account(),
        '/balance'       : (context) => const V3Balance(),
        '/fun-game'      : (context) => const V4FunGame(),
        '/feedback'      : (context) => const V5Feedback(),
        '/offers'        : (context) => const V6OffersPage(),
        '/promos'        : (context) => const V7SpecialPromosPage(),
        '/winner'        : (context) => const V8WeekWinnerPage(),

        // QR de paiement (à montrer au Drive)
        '/qr-pay'        : (context) => const VQrPay(),

        // Recharges / choix
        '/card-choice'   : (context) => const CardChoicePage(),
        '/solo'          : (context) => const SoloCardPage(),
        '/family'        : (context) => const FamilyCardPage(),
      },
    );
  }
}

/// SplashScreen : montre V0Welcome (écran “Bienvenue + QR visuel”)
/// puis redirige automatiquement vers V1 (Accueil) après 3 secondes.
/// (Pas de transition auto V1 → V1BIS : l’utilisateur choisit via un bouton.)
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
      Navigator.pushReplacementNamed(context, '/home'); // → V1
    });
  }

  @override
  Widget build(BuildContext context) {
    // On réutilise directement ton V0 comme contenu du splash
    return const V0Welcome();
  }
}
