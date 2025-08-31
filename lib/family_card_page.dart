import 'package:flutter/material.dart';

class FamilyCardPage extends StatelessWidget {
  const FamilyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sable = Color(0xFF8B5E3C);

    return Scaffold(
      appBar: AppBar(title: const Text('Recharge FAMILY')),
      backgroundColor: const Color(0xFFF8E6C8),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/family_card_visual.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD6B06E), width: 2),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recharge FAMILY",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                SizedBox(height: 6),
                Text("100 € → 150 € (50 € offerts)"),
                SizedBox(height: 8),
                Text("Parfait en famille. Recharge valable au Drive Shakir."),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Bouton Payer en caisse
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6B06E),
                foregroundColor: const Color(0xFF3E2C20),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF3E2C20), width: 1),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Payer en caisse"),
                    content: const Text(
                      "Présentez ce choix à la caisse pour régler la recharge FAMILY.\n"
                      "Une fois réglée, votre solde sera crédité automatiquement.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.store_mall_directory_rounded),
              label: const Text("Payer en caisse"),
            ),
          ),
          const SizedBox(height: 10),

          // Bouton Paiement en ligne (prochainement)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: sable,
                side: BorderSide(color: sable, width: 1.2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Paiement en ligne"),
                    content: const Text(
                      "Prochainement 🚀\nCB • PayPal • Google Pay\n\n"
                      "Bientôt, vous pourrez recharger directement depuis l’application.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.language_rounded),
              label: const Text("Paiement en ligne (prochainement)"),
            ),
          ),
          const SizedBox(height: 16),

          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Retour"),
            ),
          ),
        ],
      ),
    );
  }
}
