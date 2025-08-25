import 'package:flutter/material.dart';

class MealHistorySection extends StatelessWidget {
  const MealHistorySection({super.key, required this.plan});

  final String plan; // "SOLO" ou "FAMILY"

  @override
  Widget build(BuildContext context) {
    final items = <_Meal>[
      _Meal(date: "2025-03-01", label: "Couscous poulet", price: 17),
      _Meal(date: "2025-03-05", label: "Couscous merguez", price: 23),
      _Meal(date: "2025-03-10", label: "Couscous brochettes", price: 20),
    ];

    final total = items.fold<double>(0, (s, m) => s + m.price);

    return Card(
      color: Colors.white.withOpacity(0.96),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Historique ${plan == "SOLO" ? "SOLO" : "FAMILY"} (démo)",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            ...items.map((m) => _row(m)),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total consommé"),
                Text("${total.toStringAsFixed(2)} €",
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              "Déductions automatiques selon le repas choisi. "
              "Scan QR → mise à jour du solde et de l’historique.",
              style: TextStyle(color: Colors.black54, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(_Meal m) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const Icon(Icons.restaurant, size: 18, color: Colors.black54),
            const SizedBox(width: 8),
            Expanded(child: Text("${m.label} — ${m.date}")),
            Text("${m.price.toStringAsFixed(2)} €"),
          ],
        ),
      );
}

class _Meal {
  final String date;
  final String label;
  final double price;
  _Meal({required this.date, required this.label, required this.price});
}
