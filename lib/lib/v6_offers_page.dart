import 'package:flutter/material.dart';

class V6OffersPage extends StatelessWidget {
  const V6OffersPage({super.key});

  static const Color sand = Color(0xFF8B5E3C); // marron/sable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E5),
      appBar: AppBar(
        backgroundColor: sand,
        title: const Text('Nos Offres Drive'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _title('Plats (hors boissons & dessert)'),

          _offer(
            emoji: '🍗',
            title: 'Couscous 1/4 Poulet — légumes',
            subtitle: 'avec raisin, pois chiches et harissa',
            price: '17,00 €',
          ),
          _offer(
            emoji: '🌭',
            title: 'Couscous Merguez maison — légumes',
            subtitle: 'avec raisin, pois chiches et harissa',
            price: '20,00 €',
          ),
          _offer(
            emoji: '🍢',
            title: 'Couscous Brochettes de dinde savoureuses — légumes',
            subtitle: 'avec raisin, pois chiches et harissa',
            price: '23,00 €',
          ),

          const SizedBox(height: 12),
          const Divider(thickness: 1.2),

          _title('Suppléments'),
          _supplement('1 merguez maison', '4,00 €'),
          const SizedBox(height: 8),
          _supplement('1 brochette de dinde maison', '4,50 €'),

          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: sand,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }

  Widget _title(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      );

  Widget _offer({
    required String emoji,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 28)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: Text(price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _supplement(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        Text(price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
