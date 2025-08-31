import 'package:flutter/material.dart';

class CardChoicePage extends StatelessWidget {
  const CardChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    const sable = Color(0xFF8B5E3C);

    return Scaffold(
      backgroundColor: const Color(0xFFF8E6C8), // beige/sable doux
      appBar: AppBar(
        backgroundColor: sable,
        title: const Text('Choisir ma recharge'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          _RechargeCard(
            title: 'Recharge SOLO',
            subtitle: '50 € → 70 € (20 € offerts)',
            assetPath: 'assets/images/solo_card_visual.png', // déjà dans ton pubspec.yaml
            onTap: () => Navigator.pushNamed(context, '/solo'),
            chip: 'Idéal 1 personne',
          ),
          const SizedBox(height: 16),
          _RechargeCard(
            title: 'Recharge FAMILY',
            subtitle: '100 € → 150 € (50 € offerts)',
            assetPath: 'assets/images/family_card_visual.png', // déjà dans ton pubspec.yaml
            onTap: () => Navigator.pushNamed(context, '/family'),
            chip: 'Parfait en famille',
          ),
          const SizedBox(height: 16),
          _InfoBanner(
            icon: Icons.card_giftcard_rounded,
            text: 'À partir de 3 recharges achetées = la 4ᵉ offerte 🎁',
          ),
          const SizedBox(height: 8),
          _InfoBanner(
            icon: Icons.info_outline_rounded,
            text: 'Paiement des commandes au Drive : via QR si solde suffisant, sinon à la caisse.',
          ),
        ],
      ),
    );
  }
}

class _RechargeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetPath;
  final String chip;
  final VoidCallback onTap;

  const _RechargeCard({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.onTap,
    required this.chip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD6B06E), width: 2), // doré doux
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // visuel
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // textes
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE8B0),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF3E2C20), width: 1),
                          ),
                          child: Text(
                            chip,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E2C20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6B06E),
                      foregroundColor: const Color(0xFF3E2C20),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFF3E2C20), width: 1),
                      ),
                    ),
                    onPressed: onTap,
                    child: const Text(
                      'Choisir',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoBanner({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6B06E), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
