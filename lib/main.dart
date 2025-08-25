import 'package:flutter/material.dart';

void main() => runApp(const ShakirDriveApp());

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
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shakir Drive')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
        children: [
          // Logo centré
          Center(
            child: Image.asset(
              'assets/images/logo_shakir_drive.png',
              width: 160,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 18),
          // Slogan
          const Text(
            "1er Restaurant Drive Oriental au Monde\nà Aulnoy-lez-Valenciennes",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),

          // Bandeau “Famille de cœur”
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5E3A22), Color(0xFF936947)],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Bienvenue dans la Famille de cœur 💛\nVivez l’expérience Shakir Drive avec nous !",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),

          const SizedBox(height: 22),

          // Offres (carrousel simple)
          _OfferCard(
            title: "Offre Fidélité",
            subtitle: "3 cartes achetées = la 4ᵉ offerte",
            image: 'assets/images/offre_3plus1.png',
          ),
          const SizedBox(height: 12),
          _OfferCard(
            title: "Recharge Bonus",
            subtitle: "Recharge 100€ → Recevez 150€",
            image: 'assets/images/bonus_100_150.png',
          ),

          const SizedBox(height: 24),

          // Rappel “Drive uniquement”
          Row(
            children: const [
              Icon(Icons.local_shipping_outlined, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Service DRIVE uniquement 🚗 — Merci de votre compréhension.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Boutons (étape 1)
          FilledButton(
            onPressed: () {
              // TODO : ouvrira l’écran “Choix carte: Solo / Family”
            },
            child: const Text("Découvrir les offres"),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              // TODO : ouvrira “Scanner QR / Historique”
            },
            child: const Text("Scanner une carte / Historique"),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget
