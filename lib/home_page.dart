import 'dart:math';
import 'package:flutter/material.dart';

import 'card_choice_page.dart';
import 'solo_card_page.dart';
import 'family_card_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final int memberNumber;
  late final String numerologyNote;

  @override
  void initState() {
    super.initState();
    // Génère un "numéro de membre" local (démo). Plus tard: venir de l'API/QR.
    memberNumber = _generateMemberNumber();
    numerologyNote = _buildNumerology(memberNumber);
  }

  int _generateMemberNumber() {
    // Simple seed locale (date + aléatoire) pour varier
    final seed = DateTime.now().millisecondsSinceEpoch;
    return 1 + (Random(seed).nextInt(99999));
  }

  String _buildNumerology(int n) {
    // Réduction simple avec prise en compte des maîtres nombres 11/22/33
    int sumDigits(int x) => x.toString().split('').fold(0, (s, d) => s + int.parse(d));
    int reduced = n;
    while (reduced > 9 && reduced != 11 && reduced != 22 && reduced != 33) {
      reduced = sumDigits(reduced);
    }

    switch (reduced) {
      case 11:
        return "11 ✨ — Maître nombre ! Vision, intuition… superbe énergie.";
      case 22:
        return "22 🧱 — Maître bâtisseur ! Grands projets en vue.";
      case 33:
        return "33 💛 — Maître guérisseur ! Générosité & joie partagée.";
      case 7:
        return "7 🍀 — La chance n’est pas loin…";
      case 5:
        return "5 🚀 — Mouvement & liberté : ça bouge !";
      default:
        return "$reduced — Belle vibration pour vous aujourd’hui.";
    }
  }

  void _openCardChoice() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CardChoicePage()),
    );
  }

  void _openSolo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SoloCardPage()),
    );
  }

  void _openFamily() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FamilyCardPage()),
    );
  }

  void _showOffers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Nos offres du moment",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                _OfferCard(
                  title: "3 cartes achetées = la 4ᵉ offerte",
                  asset: "assets/images/offre_3plus1.png",
                ),
                const SizedBox(height: 12),
                _OfferCard(
                  title: "Recharge Family : 100€ = 150€",
                  asset: "assets/images/bonus_100_150.png",
                ),
                const SizedBox(height: 8),
                Text(
                  "Règlement au guichet (CB/espèces) — bientôt depuis l’app.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _scanQrPlaceholder() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Scanner un QR"),
        content: const Text(
            "À venir : scannez le QR du client pour connaître son état et l’historique des achats/offres. "
            "Déductions automatiques selon les repas (couscous poulet, merguez, brochettes…)."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))
        ],
      ),
    );
  }

  void _sendFeedback(String label, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text("Merci pour votre avis : $label"),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brownStart = const Color(0xFF4E342E); // marron foncé
    final brownEnd = const Color(0xFF795548); // marron plus clair

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shakir Drive"),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Rappel "Drive uniquement"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text(
                    "Rappel discret : service DRIVE uniquement 🚗",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                // Logo
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/logo_shakir_drive.png",
                      height: 96,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.local_fire_department,
                        size: 72,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Titre Bienvenue
                Text(
                  "Bienvenue dans la Famille de cœur 💗",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),

                const SizedBox(height: 8),

                // Sous-texte + mention 1er Drive
                Text(
                  "Vous êtes un nouveau membre de la Famille de cœur au sein de l’application Shakir Drive, "
                  "et ça nous fait très plaisir de vous compter parmi nous. Soyez les bienvenu·e·s, bisousss 😚\n\n"
                  "✨ 1er Restaurant Drive Oriental au monde — Aulnoy-lez-Valenciennes (Hauts-de-France).\n"
                  "Vivez cette expérience avec nous, la Famille.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white.withOpacity(0.95), height: 1.35),
                ),

                const SizedBox(height: 16),

                // Carte membre + numérologie
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Votre carte générée : N° $memberNumber",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Numérologie • $numerologyNote",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.brown.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // CTA principaux
                Wrap(
                  runSpacing: 12,
                  spacing: 12,
                  children: [
                    _BigButton(
                      label: "Choisir ma carte",
                      icon: Icons.credit_card,
                      onTap: _openCardChoice,
                    ),
                    _BigButton(
                      label: "Découvrir les offres",
                      icon: Icons.local_offer_rounded,
                      onTap: _showOffers,
                    ),
                    _BigButton(
                      label: "Scanner un QR",
                      icon: Icons.qr_code_scanner_rounded,
                      onTap: _scanQrPlaceholder,
                    ),
                    _BigButton(
                      label: "Solo (aperçu)",
                      icon: Icons.person,
                      onTap: _openSolo,
                    ),
                    _BigButton(
                      label: "Family (aperçu)",
                      icon: Icons.group,
                      onTap: _openFamily,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Satisfaction smileys
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Votre passage au Drive ?",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _Smiley(
                            label: "Super génial",
                            icon: Icons.sentiment_very_satisfied_rounded,
                            color: Colors.lightGreenAccent,
                            onTap: () => _sendFeedback("Super génial", Icons.sentiment_very_satisfied_rounded),
                          ),
                          _Smiley(
                            label: "Sympa",
                            icon: Icons.sentiment_satisfied_alt_rounded,
                            color: Colors.amberAccent,
                            onTap: () => _sendFeedback("Sympa", Icons.sentiment_satisfied_alt_rounded),
                          ),
                          _Smiley(
                            label: "À améliorer",
                            icon: Icons.sentiment_dissatisfied_rounded,
                            color: Colors.redAccent,
                            onTap: () => _sendFeedback("À améliorer", Icons.sentiment_dissatisfied_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Filigranes / rappel des bonus (info légère)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Solo : 50€ = 70€  •  Family : 100€ = 150€  •  Paiement au guichet (CB/espèces).",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.95)),
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

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.title, required this.asset});

  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                asset,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 140,
                  alignment: Alignment.center,
                  color: Colors.brown.shade50,
                  child: const Text("Image offre"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  const _BigButton({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.brown.shade800,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }
}

class _Smiley extends StatelessWidget {
  const _Smiley({required this.label, required this.icon, required this.color, required this.onTap});

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 30, color: color),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
