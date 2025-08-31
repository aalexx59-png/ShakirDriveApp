import 'package:flutter/material.dart';

class V6OffersPage extends StatelessWidget {
  const V6OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sable = Color(0xFF8B5E3C); // marron/sable

    return Scaffold(
      backgroundColor: const Color(0xFFF8E6C8), // fond beige sable
      appBar: AppBar(
        backgroundColor: sable,
        title: const Text("Nos Offres Drive"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _promoBanner(), // ⬅️ bannière promo en haut

          _sectionTitle("Plats (hors boissons & dessert)"),

          _offerCard(
            emoji: "🍗",
            title: "Couscous 1/4 Poulet — légumes",
            subtitle: "avec raisin, pois chiches et harissa",
            price: "17,00 €",
          ),
          _offerCard(
            emoji: "🌭",
            title: "Couscous Merguez maison — légumes",
            subtitle: "avec raisin, pois chiches et harissa",
            price: "20,00 €",
          ),
          _offerCard(
            emoji: "🍢",
            title: "Couscous 1 Brochette de dinde savoureuse — légumes",
            subtitle: "avec raisin, pois chiches et harissa",
            price: "23,00 €",
          ),

          const SizedBox(height: 20),
          const Divider(thickness: 1.5),

          _sectionTitle("Suppléments"),

          _supplementRow("1 merguez maison", "4,00 €"),
          const SizedBox(height: 10),
          _supplementRow("1 brochette de dinde maison", "4,50 €"),

          const SizedBox(height: 30),

          Center(
            child: Text(
              "Paiement au Drive : via QR si recharge, sinon à la caisse",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.brown[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 20),

          _ctaRecharge(context), // ⬅️ bouton vers /card-choice

          const SizedBox(height: 12),

          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: sable,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Retour",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Widgets privés =====

  Widget _promoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8B0), // doré doux
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF8B5E3C), width: 1.2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.card_giftcard_rounded, color: Color(0xFF8B5E3C)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "À partir de 3 recharges achetées = la 4ᵉ offerte 🎁",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF8B5E3C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _offerCard({
    required String emoji,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 30)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _supplementRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        Text(
          price,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _ctaRecharge(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD6B06E), // doré
          foregroundColor: const Color(0xFF3E2C20),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF3E2C20), width: 1),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, '/card-choice'),
        icon: const Icon(Icons.add_card_rounded),
        label: const Text(
          "Acheter une recharge",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }
}
