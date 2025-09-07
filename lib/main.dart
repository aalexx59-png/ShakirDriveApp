import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ShakirDriveApp());
}

/// Palette “oriental moderne”
class SDColors {
  static const sand = Color(0xFFF0C998);
  static const desert = Color(0xFFD89B61);
  static const clay = Color(0xFFB56D3A);
  static const night = Color(0xFF1F1B16);
  static const mint = Color(0xFF00C2A8);
  static const gold = Color(0xFFE2B857);
}

ThemeData shakirTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: SDColors.clay,
      primary: SDColors.clay,
      secondary: SDColors.mint,
      background: SDColors.sand,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: SDColors.sand,
    useMaterial3: true,
  );

  return base.copyWith(
    textTheme: GoogleFonts.cairoTextTheme(base.textTheme).apply(
      bodyColor: SDColors.night,
      displayColor: SDColors.night,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: SDColors.sand,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.cairo(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: SDColors.night,
        letterSpacing: 0.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SDColors.clay,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: SDColors.desert.withOpacity(.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: SDColors.clay, width: 1.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    ),
  );
}

class ShakirDriveApp extends StatelessWidget {
  const ShakirDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shakir Drive',
      debugShowCheckedModeBanner: false,
      theme: shakirTheme(),
      home: const RootTabs(),
    );
  }
}

/// Onglets principaux
class RootTabs extends StatefulWidget {
  const RootTabs({super.key});

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> with TickerProviderStateMixin {
  int index = 0;
  late final pages = [
    const HomeScreen(),
    const RechargeScreen(),
    const GameScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: pages[index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        backgroundColor: SDColors.sand,
        indicatorColor: SDColors.gold.withOpacity(.25),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Recharge'),
          NavigationDestination(icon: Icon(Icons.games_outlined), selectedIcon: Icon(Icons.games), label: 'Jeu'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

/// Logo animé + accueil
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const SizedBox(height: 10),
          const Center(child: AnimatedLogo(size: 128)),
          const SizedBox(height: 14),
          Center(
            child: Text(
              "SHAKIR DRIVE",
              style: GoogleFonts.cairo(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "Cartes prépayées • Recharges • Divertissement",
              style: GoogleFonts.cairo(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 22),
          _FeatureCard(
            icon: Icons.credit_score,
            title: "Paiement CB sécurisé",
            subtitle: "Prêt à intégrer Stripe / PayPal",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentScreen(amount: 0))),
          ),
          _FeatureCard(
            icon: Icons.bolt,
            title: "Recharges rapides",
            subtitle: "Deux montants dispo • 10€ & 25€",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RechargeScreen())),
          ),
          _FeatureCard(
            icon: Icons.sports_esports,
            title: "Mini-jeu Chameau 🐫",
            subtitle: "Tape pour sauter, évite les obstacles",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GameScreen())),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _FeatureCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: SDColors.gold.withOpacity(.25),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(14),
                child: Icon(icon, color: SDColors.clay, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: GoogleFonts.cairo(color: Colors.black54)),
                ]),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// Page Recharge (2 montants + paiement)
class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recharger")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          _RechargeTile(amount: 10),
          _RechargeTile(amount: 25),
          const SizedBox(height: 24),
          const _CBLogosRow(),
          const SizedBox(height: 8),
          Text(
            "Paiement CB maquetté (démo).\nPour la prod, branche Stripe/PayPal et remplace PaymentScreen par un vrai formulaire / SDK.",
            style: GoogleFonts.cairo(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _RechargeTile extends StatelessWidget {
  final int amount;
  const _RechargeTile({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.add_card, size: 30, color: SDColors.clay),
            const SizedBox(width: 12),
            Expanded(
              child: Text("Recharge ${amount}€", style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentScreen(amount: amount)));
              },
              icon: const Icon(Icons.lock),
              label: const Text("Payer"),
            ),
          ],
        ),
      ),
    );
  }
}

class _CBLogosRow extends StatelessWidget {
  const _CBLogosRow();

  @override
  Widget build(BuildContext context) {
    // Logos stylisés (texte) pour rester sans assets CB.
    final style = GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700, color: SDColors.night);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _cbBadge("VISA", Colors.blue),
        _cbBadge("Mastercard", Colors.redAccent),
        _cbBadge("CB", SDColors.mint),
        Text("Paiement sécurisé", style: style),
      ],
    );
  }

  Widget _cbBadge(String text, Color c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: c.withOpacity(.15), borderRadius: BorderRadius.circular(12)),
        child: Text(text, style: GoogleFonts.cairo(fontWeight: FontWeight.w800, color: c)),
      );
}

/// Flux paiement (démo) – ouvre un lien (ex: page Stripe Checkout test)
class PaymentScreen extends StatelessWidget {
  final int amount; // en €
  const PaymentScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse("https://example.com/pay?amount=$amount"); // TODO: remplace par ton lien Checkout
    return Scaffold(
      appBar: AppBar(title: const Text("Paiement CB")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const _CBLogosRow(),
            const SizedBox(height: 18),
            Text("Montant", style: GoogleFonts.cairo(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 6),
            Text("$amount €", style: GoogleFonts.cairo(fontSize: 40, fontWeight: FontWeight.w800)),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Paiement de démonstration", style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(
                    "Ici, branche un vrai prestataire (Stripe, PayPal…). "
                    "Tu peux ouvrir une page de paiement hébergée (Checkout) avec url_launcher.",
                    style: GoogleFonts.cairo(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => launchUrl(uri, mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.open_in_new),
                    label: Text("Payer $amount €"),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Profil – avatar agrandi + champ nom (persisté)
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final _ctrl = TextEditingController();
  String? _name;
  late final AnimationController _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _name = sp.getString('user_name');
      _ctrl.text = _name ?? "";
    });
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('user_name', _ctrl.text.trim());
    setState(() => _name = _ctrl.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nom enregistré")));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulse = Tween(begin: 1.0, end: 1.06).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),
          ScaleTransition(
            scale: pulse,
            child: CircleAvatar(
              radius: 58,
              backgroundColor: SDColors.gold.withOpacity(.35),
              child: Text("SD", style: GoogleFonts.cairo(fontSize: 36, fontWeight: FontWeight.w800, color: SDColors.clay)),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              _name?.isNotEmpty == true ? _name! : "Votre nom",
              style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _ctrl,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: "Entrer votre nom"),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save), label: const Text("Enregistrer")),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text("Confidentialité"),
            subtitle: const Text("Vos données restent sur l’appareil"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

/// Logo animé (rebond + halo)
class AnimatedLogo extends StatefulWidget {
  final double size;
  const AnimatedLogo({super.key, this.size = 100});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        final t = (sin(_c.value * pi) + 1) / 2; // 0..1
        final glow = 6.0 + 10.0 * t;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: SDColors.gold.withOpacity(.35), blurRadius: glow, spreadRadius: 1)],
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/icon/shakir_drive.png',
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: widget.size, color: Colors.black26),
            ),
          ),
        );
      },
    );
  }
}

/// Mini-jeu chameau 🐫 – simple, fun & sans dépendance
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  // Monde
  double camelY = 0; // -1 (haut) -> 1 (bas)
  double velocity = 0;
  final gravity = 0.9;
  bool running = false;
  int score = 0;

  // Obstacles (x de 1.5 -> -1.2)
  final rnd = Random();
  final List<double> obstacles = [1.5, 2.4, 3.3];

  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  void _start() {
    setState(() {
      camelY = 0;
      velocity = 0;
      score = 0;
      running = true;
      obstacles.setAll(0, [1.5, 2.4, 3.3]);
    });
    _ticker.start();
  }

  void _stop() {
    running = false;
    _ticker.stop();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Oups 🐫"),
        content: Text("Score : $score"),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  void _jump() {
    if (!running) _start();
    setState(() => velocity = -12); // saut
  }

  void _tick(Duration _) {
    // Physique chameau
    setState(() {
      velocity += gravity * 0.9;
      camelY += velocity * 0.0035;
      camelY = camelY.clamp(-1.0, 1.0);
    });

    // Déplacement obstacles
    for (var i = 0; i < obstacles.length; i++) {
      obstacles[i] -= 0.012 + min(0.01, score * 0.0008); // accélère un peu
      if (obstacles[i] < -1.2) {
        obstacles[i] = 1.5 + rnd.nextDouble(); // respawn à droite
        score++;
      }
    }

    // Collision (zone proche x ~0, y proche du sol)
    for (final x in obstacles) {
      if ((x).abs() < 0.08 && camelY > 0.65) {
        _stop();
        break;
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _jump,
      child: Scaffold(
        appBar: AppBar(title: const Text("Jeu du chameau")),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SDColors.sand, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, c) {
              final h = c.maxHeight;
              final w = c.maxWidth;

              double mapY(double y) => h * (y + 1) / 2; // -1..1 -> pixels

              return Stack(
                children: [
                  // Soleil décor
                  Positioned(
                    top: 40,
                    right: 24,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(color: SDColors.gold, shape: BoxShape.circle),
                    ),
                  ),
                  // Score
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Text("Score: $score", style: GoogleFonts.cairo(fontWeight: FontWeight.w800)),
                    ),
                  ),
                  // Sol
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 90,
                    child: Container(color: SDColors.desert.withOpacity(.35)),
                  ),
                  // Chameau 🐫
                  Positioned(
                    left: w * 0.25 - 24,
                    top: mapY(camelY) - 24,
                    child: Text("🐫", style: TextStyle(fontSize: 48, shadows: [
                      Shadow(color: Colors.black.withOpacity(.15), blurRadius: 6, offset: const Offset(1, 2))
                    ])),
                  ),
                  // Obstacles (dunes)
                  ...obstacles.map((x) {
                    final px = (x + 1) / 2 * w;
                    return Positioned(
                      left: px,
                      bottom: 60,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: SDColors.clay,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    );
                  }),
                  // Invite
                  if (!running)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Tape pour sauter !", style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text("Évite les obstacles, gagne des points", style: GoogleFonts.cairo(color: Colors.black54)),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() => running ? _stop() : _start()),
          label: Text(running ? "Pause" : "Jouer"),
          icon: Icon(running ? Icons.pause : Icons.play_arrow),
        ),
      ),
    );
  }
}
