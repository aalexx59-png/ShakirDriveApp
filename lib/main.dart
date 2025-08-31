import 'package:flutter/material.dart';

// V0 – Ecran QR de bienvenue
import 'v0_welcome.dart';

// V1 – Accueil (numéro attribué + bouton "Voir les offres")
import 'v1_home.dart';

// Choix des recharges (solo/family) + écrans dédiés
import 'card_choice_page.dart';
import 'solo_card_page.dart';
import 'family_card_page.dart';

// V4 – Mini-jeu + bandeau clignotant
import 'v4_fun_game.dart';

// V5 – Satisfaction client (3 smileys)
import 'v5_feedback_page.dart';

// V6 – Offres Drive (3 couscous + suppléments)
import 'v6_offers_page.dart';

// V7 – Promotions spéciales (anniv, fêtes, Ramadan…)
import 'v7_special_events_page.dart';

// V8 – Gagnant de la semaine (numéro + repas offert)
import 'v8_week_winner_page.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF8B5E3C), // sable/orangé doux
        appBarTheme: const AppBarTheme(
          backgroundColor: sable,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: false,
      ),

      /// Point d’entrée : V0 (scan QR)
      initialRoute: '/',

      /// Routes déclarées
      routes: {
        // V0
        '/': (context) => const V0Welcome(),

        // V1
        '/home': (context) => const V1Home(),

        // Choix et écrans de recharges
        '/card-choice': (context) => const CardChoicePage(),
        '/solo': (context) => const SoloCardPage(),
        '/family': (context) => const FamilyCardPage(),

        // V4 / V5 / V6 / V7
        '/game': (context) => const V4FunGame(),
        '/feedback': (context) => const V5FeedbackPage(),
        '/offers': (context) => const V6OffersPage(),
        '/specials': (context) => const V7SpecialEventsPage(),

        // V8 (le numéro gagnant est récupéré via `arguments` dans la page)
        '/winner': (context) => const V8WeekWinnerPage(),
      },
    );
  }
}
