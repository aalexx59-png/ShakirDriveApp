import 'package:flutter/material.dart';

class V2Account extends StatelessWidget {
  const V2Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text("Mon compte"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD6B06E), width: 2), // bordure dorée
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Solde + Dernier paiement (rappel léger)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _InfoChip(label: "Solde", value: "45 €"),
                    _InfoChip(label: "Dernier paiement", value: "-12 €"),
                  ],
                ),
                const SizedBox(height: 16),

                // Historique des achats
                const Text(
                  "Historique des achats",
                  style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: Colors.brown),
                ),
                const SizedBox(height: 10),
                const _HistoryTile(
                  title: "Couscous Poulet",
                  subtitle: "12,90 € • 28/08",
                ),
                const _HistoryTile(
                  title: "Couscous Merguez",
                  subtitle: "13,90 € • 26/08",
                ),
                const _HistoryTile(
                  title: "Recharge Family 100 → 150",
                  subtitle: "+50 € offerts • 25/08",
                ),
                const SizedBox(height: 22),

                // Paiement / Rechargement (deux boutons dorés)
                const Text(
                  "Paiement / Rechargement",
                  style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: Colors.brown),
                ),
                const SizedBox(height: 12),

                // Bouton caisse (actif)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6B06E), // doré
                      foregroundColor: const Color(0xFF3E2C20), // texte marron foncé
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFF3E2C20), width: 1),
                      ),
                    ),
                    onPressed: () {
                      // TODO: ouvrir l'écran "paiement en caisse" ou afficher modal
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Paiement en caisse")),
                      );
                    },
                    icon: const Icon(Icons.store_mall_directory_rounded),
                    label: const Text("Paiement en caisse"),
                  ),
                ),
                const SizedBox(height: 10),

                // Bouton en ligne (prochainement) — même doré, info à l'appui
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6B06E), // doré (même couleur)
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
                          title: const Text("Paiement en ligne"),
                          content: const Text(
                            "Prochainement 🚀\nCB • PayPal • Google Pay\n\nLe paiement en ligne arrive très bientôt pour encore plus de confort.",
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
                    label: const Text("Paiement en ligne (Prochainement)"),
                  ),
                ),
                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "CB   |   PayPal   |   Google Pay",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Center(
                  child: Text(
                    "Le paiement en ligne arrive très bientôt pour encore plus de confort ✨",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD6B06E), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              fontWeight: FontWeight.w700, color: Colors.brown),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const _HistoryTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      subtitle: Text(subtitle),
      leading: const Icon(Icons.receipt_long, color: Colors.brown),
    );
  }
}
