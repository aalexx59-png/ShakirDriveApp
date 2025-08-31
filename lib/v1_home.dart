import 'package:flutter/material.dart';

class V1Home extends StatelessWidget {
  const V1Home({super.key});

  @override
  Widget build(BuildContext context) {
    const int numeroClient = 1111;

    // Numérologie simple (somme des chiffres)
    final int somme = numeroClient
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.all(20),
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
                    const SizedBox(height: 8),
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
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Bouton 1 : Acheter une recharge
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6B06E), // doré
                    foregroundColor: const Color(0xFF3E2C20),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFF3E2C20), width: 1),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/card-choice'),
                  child: const Text(
                    "Acheter une recharge",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Bouton 2 : Mon QR de paiement
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.brown[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.brown.shade600, width: 1),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/qr-pay'),
                  icon: const Icon(Icons.qr_code_rounded),
                  label: const Text(
                    "Mon QR de paiement",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Liens secondaires (facultatifs)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/account'),
                    child: const Text(
                      "Mon compte",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Text(" • ", style: TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/offers'),
                    child: const Text(
                      "Nos offres Drive",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
