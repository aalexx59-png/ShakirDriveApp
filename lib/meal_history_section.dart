import 'package:flutter/material.dart';

class MealHistorySection extends StatelessWidget {
  final List<Map<String, String>> mealHistory;

  const MealHistorySection({super.key, required this.mealHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Historique des repas",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (mealHistory.isEmpty)
          const Text("Aucun repas enregistré pour le moment."),
        ...mealHistory.map((meal) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.fastfood),
              title: Text(meal['name'] ?? 'Repas'),
              subtitle: Text("Date : ${meal['date'] ?? 'Inconnue'}"),
            ),
          );
        }).toList(),
      ],
    );
  }
}
