import 'package:flutter/material.dart';

class SoloCardPage extends StatelessWidget {
  const SoloCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const brownStart = Color(0xFF4E342E);
    const brownEnd   = Color(0xFF795548);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carte SOLO"),
        backgroundColor: brownStart,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [brownStart, brownEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            children: [
              // Bandeau info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  "Service DRIVE uniquement 🚗 — Paiement au guichet (CB/espèces).",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),

              // Carte SOLO (avec filigrane)
              Stack(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Carte SOLO",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 6),
                          Text("Idéale pour 1 personne • Avantage de bienvenue"),
                          SizedBox(height: 10),
                          _Bullet("Bonus de recharge : 50€ → 70€ (soit +20€)"),
                          _Bullet("Suivi clair des repas (couscous poulet, merguez, brochettes…)"),
                          _Bullet("Historique et déductions automatiques"),
                        ],
                      ),
                    ),
                  ),
                  // Filigrane discret
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Center(
                        child: Opacity(
                          opacity: 0.10,
                          child: Transform.rotate(
                            angle: -0.25,
                            child: const Text(
                              "50€ = 70€",
                              style: TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Actions principales
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Activation au guichet : après paiement, un QR vous est remis pour activer votre carte dans l’app.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.store_rounded),
                      label: const Text("Activer au guichet"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.brown.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Scanner un QR (démo)"),
                            content: const Text(
                              "Ici, vous scannerez le QR remis au guichet pour activer la carte SOLO.\n"
                              "La carte virtuelle sera créée avec votre numéro Famille de Cœur.",
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner_rounded),
                      label: const Text("Scanner un QR"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Conseils / petit encart
              Card(
                color: Colors.white.withOpacity(0.96),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Astuce ✨ : après activation, votre numéro membre s’affiche et un message de numérologie apparaît "
                    "(ex. 11 = maître nombre, 7 = chance…).",
                    style: TextStyle(height: 1.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
