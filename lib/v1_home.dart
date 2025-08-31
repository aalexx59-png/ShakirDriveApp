import 'package:flutter/material.dart';

class V1Home extends StatelessWidget {
  const V1Home({super.key});

  @override
  Widget build(BuildContext context) {
    const int numeroClient = 1111;

    final int somme = numeroClient
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFFFF8B5E3C), // fond sable/marron
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue dans la Famille de cœur 💛",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Bloc numéro attribué
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "🎉 Félicitations 🎉",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Vous êtes le numéro",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    numeroClient.toString(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$somme – Le chiffre de la stabilité et de la force",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Bouton pour aller vers V1 BIS
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // style doré
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home-bis');
              },
              child: const Text(
                "Compléter mon profil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 12),

            // Bouton pour voir les offres (si tu veux le garder)
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/card-choice'),
              child: const Text(
                "Voir les offres »",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
