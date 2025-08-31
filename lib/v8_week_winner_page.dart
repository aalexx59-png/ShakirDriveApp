import 'package:flutter/material.dart';

/// Ecran "Gagnant de la semaine"
/// - Affiche le numéro gagnant (reçu via arguments ou valeur par défaut)
/// - Message "Un repas offert au choix"
/// - Teasing "Peut-être vous le prochain gagnant…"
/// - Petit effet festif (confettis simples animés sans package)
class V8WeekWinnerPage extends StatefulWidget {
  const V8WeekWinnerPage({super.key});

  @override
  State<V8WeekWinnerPage> createState() => _V8WeekWinnerPageState();
}

class _V8WeekWinnerPageState extends State<V8WeekWinnerPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.96,
      upperBound: 1.04,
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Récupère le numéro gagnant passé via Navigator.pushNamed(..., arguments: 4321)
    final int winningNumber =
        (ModalRoute.of(context)?.settings.arguments as int?) ?? 4321;

    const sable = Color(0xFF8B5E3C); // marron-sable pour cohérence visuelle
    const doreClair = Color(0xFFFFE8B0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8B5E3C), // fond sable clair
      appBar: AppBar(
        backgroundColor: sable,
        elevation: 0,
        title: const Text('Gagnant de la semaine'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // "Confettis" simples
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) => CustomPaint(
                    painter: _ConfettiPainter(progress: _controller.value),
                  ),
                ),
              ),
            ),

            // Contenu
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: sable,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '🎉 Gagnant de la semaine',
                        style: TextStyle(
                          color: doreClair,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ScaleTransition(
                        scale: _pulse,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 14),
                          decoration: BoxDecoration(
                            color: doreClair,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '$winningNumber',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: Colors.brown,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Un repas offert au choix 🍽️',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: doreClair,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // CTA "Voir les repas au choix"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigue vers l’écran des offres/menus si tu as la route
                      Navigator.pushNamed(context, '/offers');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sable,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Voir les repas au choix',
                      style: TextStyle(
                        color: doreClair,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Teasing
                Container(
                  decoration: BoxDecoration(
                    color: doreClair,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.brown.shade300),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: const Text(
                    'Peut-être vous le prochain gagnant, la famille 💛\n'
                    'Restez connectés : tirage chaque semaine !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Petit painter pour des confettis très légers (sans packages)
class _ConfettiPainter extends CustomPainter {
  final double progress;
  _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = [
      const Offset(30, 40),
      const Offset(120, 90),
      const Offset(220, 60),
      const Offset(80, 160),
      const Offset(300, 140),
      const Offset(50, 260),
      const Offset(180, 220),
      const Offset(260, 300),
      const Offset(110, 320),
    ];

    final paints = [
      Paint()..color = Colors.brown.withOpacity(0.15),
      Paint()..color = const Color(0xFFFFE8B0).withOpacity(0.25),
      Paint()..color = Colors.orange.withOpacity(0.2),
    ];

    for (int i = 0; i < rnd.length; i++) {
      final dy = rnd[i].dy + (progress * 30 * ((i % 3) + 1));
      final dx = rnd[i].dx + (progress * 8 * (i.isEven ? 1 : -1));
      final p = paints[i % paints.length];
      canvas.drawCircle(Offset(dx, dy) % size, 6 + (i % 4).toDouble(), p);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
