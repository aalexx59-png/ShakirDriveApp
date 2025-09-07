import 'package:flutter/material.dart';

void main() {
  runApp(const ShakirDriveApp());
}

class ShakirDriveApp extends StatelessWidget {
  const ShakirDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHAKIR DRIVE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB86E2A)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Page d’accueil (welcome)
      home: const WelcomeScreen(),
      // onGenerateRoute pour produire dynamiquement les écrans d’images
      onGenerateRoute: (settings) {
        final route = settings.name ?? '';
        final page = _routeToPage(route);
        if (page != null) {
          return MaterialPageRoute(builder: (_) => page);
        }
        // fallback
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
    );
  }
}

/* --------------------------- ROUTING & FACTORY --------------------------- */

Widget? _routeToPage(String route) {
  switch (route) {
    case Routes.home:
      return const HomeScreen();
    case Routes.profile:
      return const SimpleImageScreen(
        title: 'Profil',
        assetPath: 'assets/images/v1bis_profile.png',
      );
    case Routes.recharge:
      return const SimpleImageScreen(
        title: 'Recharge',
        assetPath: 'assets/images/v5bis_recharge_promo.png',
      );
    case Routes.familyCard:
      return const SimpleImageScreen(
        title: 'Carte Famille',
        assetPath: 'assets/images/v2_family_card.png',
      );
    case Routes.soloCard:
      return const SimpleImageScreen(
        title: 'Carte Solo',
        assetPath: 'assets/images/v2_solo_card.jpg',
      );
    case Routes.history:
      return const SimpleImageScreen(
        title: 'Historique',
        assetPath: 'assets/images/v3_history.png',
      );
    case Routes.funGame:
      return const SimpleImageScreen(
        title: 'Fun Game',
        assetPath: 'assets/images/v4_fun_game.png',
      );
    case Routes.feedback:
      return const SimpleImageScreen(
        title: 'Feedback',
        assetPath: 'assets/images/v5_feedback.png',
      );
    case Routes.offers:
      return const SimpleImageScreen(
        title: 'Offres',
        assetPath: 'assets/images/v6_offers.png',
      );
    case Routes.special:
      return const SimpleImageScreen(
        title: 'Spécial',
        assetPath: 'assets/images/v7_special.png',
      );
    case Routes.winner:
      return const SimpleImageScreen(
        title: 'Gagnant',
        assetPath: 'assets/images/v8_winner.png',
      );
    case Routes.about:
      return const AboutScreen();
    default:
      return null;
  }
}

class Routes {
  static const home = '/home';
  static const profile = '/profile';
  static const recharge = '/recharge';
  static const familyCard = '/family';
  static const soloCard = '/solo';
  static const history = '/history';
  static const funGame = '/fun';
  static const feedback = '/feedback';
  static const offers = '/offers';
  static const special = '/special';
  static const winner = '/winner';
  static const about = '/about';
}

/* ----------------------------- WELCOME PAGE ------------------------------ */

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo app
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  'assets/icon/shakir_drive.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'SHAKIR DRIVE',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bienvenue 👋',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // Image de bienvenue si dispo
              Expanded(
                child: Image.asset(
                  'assets/images/v0_welcome.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Entrer'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------- HOME ---------------------------------- */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      drawer: const _AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Image.asset(
            'assets/images/v1_home.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

/* ------------------------- ECRAN D’IMAGE GENERIQUE ----------------------- */

class SimpleImageScreen extends StatelessWidget {
  final String title;
  final String assetPath;

  const SimpleImageScreen({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const _AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

/* -------------------------------- ABOUT --------------------------------- */

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      drawer: const _AppDrawer(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "Shakir DRIVE\n\nVersion 1.0.0\n\n© 2025 Shakir. Tous droits réservés.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/* ------------------------------- DRAWER --------------------------------- */

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    void go(String route) {
      // Remplace la page courante par la cible
      Navigator.of(context).pushReplacementNamed(route);
    }

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/icon/shakir_drive.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'SHAKIR DRIVE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _tile(Icons.home, 'Accueil', () => go(Routes.home)),
            const Divider(height: 1),
            _tile(Icons.person, 'Profil', () => go(Routes.profile)),
            _tile(Icons.bolt, 'Recharge', () => go(Routes.recharge)),
            _tile(Icons.group, 'Carte Famille', () => go(Routes.familyCard)),
            _tile(Icons.person_outline, 'Carte Solo', () => go(Routes.soloCard)),
            _tile(Icons.history, 'Historique', () => go(Routes.history)),
            _tile(Icons.videogame_asset, 'Fun Game', () => go(Routes.funGame)),
            _tile(Icons.local_offer, 'Offres', () => go(Routes.offers)),
            _tile(Icons.star, 'Spécial', () => go(Routes.special)),
            _tile(Icons.emoji_events, 'Gagnant', () => go(Routes.winner)),
            _tile(Icons.feedback, 'Feedback', () => go(Routes.feedback)),
            const Divider(height: 1),
            _tile(Icons.info_outline, 'À propos', () => go(Routes.about)),
          ],
        ),
      ),
    );
  }

  ListTile _tile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
