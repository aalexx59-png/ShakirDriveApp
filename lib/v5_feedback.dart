import 'package:flutter/material.dart';

class V5Feedback extends StatelessWidget {
  const V5Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text("Satisfaction Client"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Votre avis compte beaucoup 💛",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Aidez-nous à nous améliorer,\nFamille de cœur ✨",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              // 3 smileys de satisfaction
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _SmileyFeedback(
                      emoji: "😡",
                      label: "À améliorer",
                      color: Colors.red,
                    ),
                    _SmileyFeedback(
                      emoji: "😐",
                      label: "Correct",
                      color: Colors.orange,
                    ),
                    _SmileyFeedback(
                      emoji: "🤩",
                      label: "Super génial",
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmileyFeedback extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;

  const _SmileyFeedback({
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Merci pour votre retour : $label"),
            backgroundColor: color,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
