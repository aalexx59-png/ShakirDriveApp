import 'package:flutter/material.dart';

class V7SpecialPromosPage extends StatefulWidget {
  const V7SpecialPromosPage({super.key});

  @override
  State<V7SpecialPromosPage> createState() => _V7SpecialPromosPageState();
}

class _V7SpecialPromosPageState extends State<V7SpecialPromosPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true); // petit effet "respiration" ludique
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sable = Color(0xFFF8B5E3C); // fond sable/marron doux (proche du thème)
    return Scaffold(
      backgroundColor: sable,
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        elevation: 0,
        title: const Text(
          'Promotions spéciales',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            // Bandeau d’intro avec vibe “filigrane”
            Container(
              decoration: BoxDecoration(
                color: Colors.brown[700],
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Un moment spécial ? On s’occupe du reste ✨',
                    style: TextStyle(
                      color: Color(0xFFFFE8B0),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Anniversaire, Fête des mères/pères, Ramadan… '
                    'profitez d’offres dédiées pour célébrer avec la famille de cœur.',
                    style: TextStyle(
                      color: Colors.brown[100],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            _PromoCard(
              emoji: '🎂',
              title: 'Offre Anniversaire',
              lines: const [
                '— 1 dessert oriental offert pour la table',
                '— Message personnalisé en caisse',
                '— Bonus de +5€ sur votre prochaine recharge',
              ],
              cta: 'Activer pour mon anniversaire',
              onTap: () {
                _showSnack('Offre anniversaire notée 🎉');
              },
              anim: _anim,
            ),
            const SizedBox(height: 14),

            _PromoCard(
              emoji: '🌙',
              title: 'Spécial Ramadan',
              lines: const [
                '— Menu Iftar à tarif doux',
                '— Priorité Drive aux heures d’affluence',
                '— +10% de bonus sur la recharge du soir',
              ],
              cta: 'Voir le menu Iftar',
              onTap: () {
                _showSnack('Menu Iftar bientôt disponible 🌙');
              },
              anim: _anim,
            ),
            const SizedBox(height: 14),

            _PromoCard(
              emoji: '👩‍👧‍👦',
              title: 'Fête des Mères & Pères',
              lines: const [
                '— 1 boisson chaude offerte',
                '— Photo souvenir “Famille de cœur”',
                '— +5% de bonus sur recharge Family',
              ],
              cta: 'Je prépare la surprise',
              onTap: () {
                _showSnack('Surprise enregistrée 💛');
              },
              anim: _anim,
            ),
            const SizedBox(height: 22),

            // Petit bloc ludique “à gratter” (simulé)
            _ScratchLike(
              anim: _anim,
              onReveal: () => _showSnack('Bravo ! -5% sur une commande 🎁'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final String emoji;
  final String title;
  final List<String> lines;
  final String cta;
  final VoidCallback onTap;
  final AnimationController anim;

  const _PromoCard({
    required this.emoji,
    required this.title,
    required this.lines,
    required this.cta,
    required this.onTap,
    required this.anim,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: anim,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFE8B0), // doré doux
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$emoji  $title',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            ...lines
                .map((l) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(l,
                          style: const TextStyle(
                            color: Colors.brown,
                            height: 1.25,
                          )),
                    ))
                .toList(),
            const SizedBox(height: 12),
