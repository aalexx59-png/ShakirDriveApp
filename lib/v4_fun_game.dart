import 'package:flutter/material.dart';

class V4FunGame extends StatefulWidget {
  const V4FunGame({super.key});

  @override
  State<V4FunGame> createState() => _V4FunGameState();
}

class _V4FunGameState extends State<V4FunGame> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Animation du bandeau clignotant
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.orangeAccent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text("Mini-jeu"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Bandeau clignotant
          AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: _colorAnimation.value,
              child: const Text(
                "✨ JOUER EN ATTENDANT VOTRE COMMANDE ✨",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Zone de jeu simplifiée
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sports_esports, size: 100, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Mini-jeu à venir 🎮🐪",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Le jeu arrive bientôt 🚀"),
                        ),
                      );
                    },
                    child: const Text("Lancer le jeu"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
