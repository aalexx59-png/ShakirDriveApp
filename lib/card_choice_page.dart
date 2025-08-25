import 'package:flutter/material.dart';
import 'solo_card_page.dart';
import 'family_card_page.dart';

class CardChoicePage extends StatelessWidget {
  const CardChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brownStart = const Color(0xFF4E342E);
    final brownEnd = const Color(0xFF795548);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choisir ma carte"),
        backgroundColor: brownStart,
      ),
      body: Container(
        decoration: BoxDecoration(
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
              // Rappel Drive uniquement
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  "Service DRIVE uniquement 🚗",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),

              // Carte SOLO
              _ChoiceCard(
                title: "Carte SOLO",
                subtitle: "Idéal pour 1 personne • Avantage de bienvenue",
                bullets: const [
                  "Filigrane avantage : 50€ = 70€",
                  "Suivi de vos repas (couscous poulet, merguez, brochettes…) avec déductions auto.",
                  "Règlement au guichet (CB/espèces) — bientôt dans l’app.",
                ],
                ctaLabel: "Voir la carte Solo",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SoloCardPage()),
                ),
                imageAsset: "assets/images/bonus_100_150.png", // fallback si manquant
              ),
              const SizedBox(height: 14),

              // Carte FAMILY
              _ChoiceCard(
                title: "Carte FAMILY",
                subtitle: "Pour la famille ou les amis • Max de bonus",
                bullets: const [
                  "Filigrane avantage : 100€ = 150€",
                  "Partage facile entre proches, historique consolidé.",
                  "Règlement au guichet (CB/espèces) — bientôt dans l’app.",
                ],
                ctaLabel: "Voir la carte Family",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FamilyCardPage()),
                ),
                imageAsset: "assets/images/offre_3plus1.png", // fallback si manquant
              ),
              const SizedBox(height: 18),

              // Offre 3+1
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BON PLAN 🎁 3 cartes achetées = la 4ᵉ offerte",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Cumulez rapidement des avantages et partagez avec vos proches.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.title,
    required this.subtitle,
    required this.bullets,
    required this.ctaLabel,
    required this.onTap,
    this.imageAsset,
  });

  final String title;
  final String subtitle;
  final List<String> bullets;
  final String ctaLabel;
  final VoidCallback onTap;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageAsset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageAsset!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    alignment: Alignment.center,
                    color: const Color(0xFFF2EDEB),
                    child: const Text("Aperçu carte"),
                  ),
                ),
              ),
            if (imageAsset != null) const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(subtitle),
            const SizedBox(height: 8),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(child: Text(b)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(ctaLabel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
