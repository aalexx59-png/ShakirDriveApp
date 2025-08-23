import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ShakirApp());
}

class ShakirApp extends StatelessWidget {
  const ShakirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHAKIR Drive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB76E2A)),
        useMaterial3: true,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const OffersPage(),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Solde'),
          NavigationDestination(icon: Icon(Icons.local_offer_outlined), label: 'Offres'),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _balance = 0.0;
  int _cardsPurchased = 0;
  String _userId = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id') ?? UniqueKey().toString();
    await prefs.setString('user_id', id);
    final bal = prefs.getDouble('balance') ?? 0.0;
    final count = prefs.getInt('cards_purchased') ?? 0;
    setState(() {
      _userId = id;
      _balance = bal;
      _cardsPurchased = count;
      _loading = false;
    });
  }

  Future<void> _setBalance(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', value);
    setState(() {
      _balance = value;
    });
  }

  Future<void> _incCardsPurchased() async {
    final prefs = await SharedPreferences.getInstance();
    final next = (_cardsPurchased + 1);
    await prefs.setInt('cards_purchased', next);
    setState(() {
      _cardsPurchased = next;
    });
  }

  Future<void> _recharge(double amount, double bonus) async {
    final newBalance = _balance + amount + bonus;
    await _setBalance(newBalance);
    await _incCardsPurchased();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recharge: +${amount.toStringAsFixed(2)}€ + bonus ${bonus.toStringAsFixed(2)}€')),
      );
    }
  }

  Future<void> _spend(double amount) async {
    if (amount <= 0) return;
    if (amount > _balance) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solde insuffisant')));
      }
      return;
    }
    await _setBalance(_balance - amount);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final eligibleFree = (_cardsPurchased >= 3);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHAKIR - Cartes prépayées'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/Screenshot_20250823_122352_Chrome.jpg', width: 56, height: 56, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bienvenue au Drive SHAKIR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('ID client: ${_userId.substring(0, 8)}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (eligibleFree)
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.card_giftcard_outlined),
                      const SizedBox(width: 8),
                      Expanded(child: Text('🎉 Bravo ! 3 cartes achetées. La prochaine est OFFERTE.')),
                      Text('x$_cardsPurchased'),
                    ],
                  ),
                ),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.loyalty_outlined),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Cartes achetées : $_cardsPurchased / 3')),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Card(
              elevation: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Solde', style: TextStyle(fontSize: 16)),
                    Text('${_balance.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Recharger', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _recharge(50, 20), // 50€ -> 70€
                    child: const Text('50€ ➜ 70€'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _recharge(100, 50), // 100€ -> 150€
                    child: const Text('100€ ➜ 150€'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Payer au Drive (QR)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1),
                ),
                child: QrImageView(
                  data: jsonEncode({
                    'userId': _userId,
                    'balance': _balance,
                    'ts': DateTime.now().millisecondsSinceEpoch,
                  }),
                  version: QrVersions.auto,
                  size: 180,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Dépenser (test local)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final price in [10, 17, 20, 23])
                  OutlinedButton(
                    onPressed: () => _spend(price.toDouble()),
                    child: Text('-${price.toStringAsFixed(0)}€'),
                  ),
              ],
            ),
            const Spacer(),
            const Text(
              'Offres: 50€→70€, 100€→150€. 3 cartes achetées = 4e offerte.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes offres')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset('assets/images/promo_solo_family.jpg'),
                const ListTile(
                  title: Text('Cartes prépayées'),
                  subtitle: Text('50€→70€ • 100€→150€'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset('assets/images/promo_3plus1.jpg'),
                const ListTile(
                  title: Text('Fidélité'),
                  subtitle: Text('3 cartes achetées, la 4e offerte'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Valables uniquement au Drive — Offres limitées',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
