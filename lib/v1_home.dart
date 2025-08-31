import 'package:flutter/material.dart';

class V1Home extends StatelessWidget {
  final int numeroClient;

  const V1Home({super.key, required this.numeroClient});

  @override
  Widget build(BuildContext context) {
    // Exemple de numérologie simple
    int somme = numeroClient
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue dans la Famille de cœur 💛",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Bloc numéro attribué
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "🎉 Félicitations 🎉",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Vous êtes le numéro",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
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

            const SizedBox(height: 40),

            // Bouton navigation
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/card-choice');
              },
              child: const Text(
                "Voir les offres ➡️",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
