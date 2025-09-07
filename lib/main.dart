        _RechargeCard(
          title: 'Recharge Rapide',
          subtitle: '10 000 XOF',
          benefits: ['+ Bonus 2%', 'Activation immédiate'],
        ),
        SizedBox(height: 12),
        _RechargeCard(
          title: 'Recharge Maxi',
          subtitle: '25 000 XOF',
          benefits: ['+ Bonus 6%', 'Priorité support'],
        ),
      ],
    );
  }
}

class _RechargeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> benefits;

  const _RechargeCard({
    required this.title,
    required this.subtitle,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title, style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800)),
                ),
                Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            ...benefits.map((b) => Row(
              children: [
                const Icon(Icons.check_circle, size: 18, color: Colors.green),
                const SizedBox(width: 6),
                Text(b),
              ],
            )),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showPaymentMock(context, 'Mobile Money'),
                    icon: const Icon(Icons.phone_android),
                    label: const Text('Payer Mobile Money'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _showPaymentMock(context, 'Carte Bancaire'),
                    icon: const Icon(Icons.credit_card),
                    label: const Text('Payer Carte'),
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

/// —————————————————————————————
/// 3) PROFIL : avatar large + nom editable
/// —————————————————————————————
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _ctrl = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _ctrl.text = prefs.getString('user_name') ?? '';
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _ctrl.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nom enregistré ✅')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 56,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/icon/shakir_drive.png'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Mon Profil',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _ctrl,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Votre nom',
            hintText: 'Entrez votre nom',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.badge_outlined),
          ),
          onSubmitted: (_) => _save(),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Enregistrer'),
        ),
      ],
    );
  }
}

/// —————————————————————————————
/// 4) MINI-JEU : Chameau 🐫 qui saute un cactus
/// —————————————————————————————
/// Gameplay très simple : appuyer pour sauter, éviter le cactus.
/// (sans packages externes)
class CamelGameScreen extends StatefulWidget {
  const CamelGameScreen({super.key});

  @override
  State<CamelGameScreen> createState() => _CamelGameScreenState();
}

class _CamelGameScreenState extends State<CamelGameScreen>
    with SingleTickerProviderStateMixin {
  static const double ground = 140;
  static const double camelSize = 46;
  static const double cactusWidth = 28;

  late final Ticker _ticker;
  double _vy = 0;            // vitesse verticale
  double _y = ground;        // hauteur camel (du bas)
  double _xCactus = 400;     // position cactus
  bool _running = false;
  int _score = 0;
  final _rand = Random();

  @override
  void initState() {
    super.initState();
    _y = ground;
    _ticker = createTicker(_tick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _score = 0;
      _y = ground;
      _vy = 0;
      _xCactus = 360 + _rand.nextInt(120);
      _running = true;
    });
    _ticker.start();
  }

  void _jump() {
    if (!_running) {
      _start();
      return;
    }
    if (_y <= ground + 0.1) {
      // impulsion
      _vy = 8.5;
    }
  }

  void _tick(Duration elapsed) {
    // dt “fixe” pour une anim simple ~60fps
    const dt = 1 / 60.0;

    // physique simple
    _vy -= 20 * dt;          // gravité
    _y += _vy;

    if (_y < ground) {
      _y = ground;
      _vy = 0;
    }

    // déplacement cactus
    _xCactus -= 160 * dt;
    if (_xCactus < -cactusWidth) {
      _xCactus = 360 + _rand.nextInt(180);
      _score++;
    }

    // collision
    final camelLeft = 40.0;
    final camelRight = camelLeft + camelSize;
    final cactusLeft = _xCactus;
    final cactusRight = _xCactus + cactusWidth;
    final camelBottom = _y;
    final camelTop = _y + camelSize;

    final overlapX = camelRight > cactusLeft && camelLeft < cactusRight;
    final overlapY = camelBottom < (ground + cactusWidth) && camelTop > ground;

    if (overlapX && overlapY) {
      _ticker.stop();
      _running = false;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Oups 💥  Score: $_score')),
        );
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _jump,
      child: Container(
        color: Colors.orange.shade50,
        child: Stack(
          children: [
            // sol
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: ground, color: Colors.brown.shade100),
            ),
            // chameau
            Positioned(
              left: 40,
              bottom: _y,
              child: _Camel(),
            ),
            // cactus
            Positioned(
              left: _xCactus,
              bottom: ground,
              child: _Cactus(w: cactusWidth, h: 44),
            ),
            // score + bouton start
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Score: $_score',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            if (!_running)
              Center(
                child: FilledButton.icon(
                  onPressed: _start,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Jouer'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Camel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // icône “chameau” stylisée
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.brown.shade300,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
      ),
      alignment: Alignment.center,
      child: const Text('🐫', style: TextStyle(fontSize: 24)),
    );
  }
}

class _Cactus extends StatelessWidget {
  final double w;
  final double h;
  const _Cactus({required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black26)],
      ),
    );
  }
}
