import 'package:flutter/material.dart';

class SoloCardPage extends StatelessWidget {
  const SoloCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte Solo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Carte Solo - 50€ = 70€",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Avantages :\n- Idéal pour les petits plaisirs\n- QR Code personnel",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Retour"),
            ),
          ],
        ),
      ),
    );
  }
}
