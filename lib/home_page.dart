import 'package:flutter/material.dart';
import 'card_choice_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shakir Drive"),
        backgroundColor: const Color(0xFF3E2C22), // marron foncé
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          // Logo
          Center(
            child: Image.asset(
              "assets/images/logo_shakir_drive.png",
              width: 160,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          // Slogan
          const Text(
            "1er Restaurant Drive Oriental au Monde\nà Aulnoy-lez-Valenciennes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          // Famille de cœur
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF5E3A22), Color(0xFF936947)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Text(
              "Bienvenue dans la Famille de cœur 💗\nVivez l’expérience Shakir Drive avec nous !",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const SizedBox(height: 30),
          // Bouton pour aller vers le choix de carte
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E2C22),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CardChoicePage()),
              );
            },
            child: const Text("Choisir ma carte"),
          ),
        ],
      ),
    );
  }
}
