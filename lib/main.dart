import 'package:flutter/material.dart';

void main() {
  runApp(const ShakirDriveApp());
}

class ShakirDriveApp extends StatelessWidget {
  const ShakirDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shakir Drive',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const WelcomePage(),
    );
  }
}

// ================== V0 ==================
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Center(
          child: Image.asset("assets/images/v0_welcome.png"),
        ),
      ),
    );
  }
}

// ================== V1 ==================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/v1_home.png"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: const Text("Mon profil"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CardsPage()));
            },
            child: const Text("Mes cartes"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
            child: const Text("Historique"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FunGamePage()));
            },
            child: const Text("Mini-Jeu"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()));
            },
            child: const Text("Avis client"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OffersPage()));
            },
            child: const Text("Offres Drive"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SpecialPage()));
            },
            child: const Text("Promotions spéciales"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WinnerPage()));
            },
            child: const Text("Gagnant de la semaine"),
          ),
        ],
      ),
    );
  }
}

// ================== V1bis ==================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v1bis_profile.png"),
      ),
    );
  }
}

// ================== V2 (2 images) ==================
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/v2_solo_card.jpg"),
          Image.asset("assets/images/v2_family_card.png"),
        ],
      ),
    );
  }
}

// ================== V3 ==================
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v3_history.png"),
      ),
    );
  }
}

// ================== V4 ==================
class FunGamePage extends StatelessWidget {
  const FunGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v4_fun_game.png"),
      ),
    );
  }
}

// ================== V5 ==================
class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/v5_feedback.png"),
          Image.asset("assets/images/v5bis_recharge_promo.png"),
        ],
      ),
    );
  }
}

// ================== V6 ==================
class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v6_offers.png"),
      ),
    );
  }
}

// ================== V7 ==================
class SpecialPage extends StatelessWidget {
  const SpecialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v7_special.png"),
      ),
    );
  }
}

// ================== V8 ==================
class WinnerPage extends StatelessWidget {
  const WinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/v8_winner.png"),
      ),
    );
  }
}
