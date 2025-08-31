import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

class VQrPay extends StatelessWidget {
  const VQrPay({super.key});

  String _generateNonce(int len) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random.secure();
    return List.generate(len, (_) => chars[rnd.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    // Ex : récup depuis storage / login
    const userId = 'user_abc123';
    final ts = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final payload = {
      "v": 1,
      "uid": userId,
      "ts": ts,
      "nonce": _generateNonce(16),
      "type": "pay"
    };

    final qrData = payload.toString(); // idéalement : JSON ou JWT signé

    return Scaffold(
      appBar: AppBar(title: const Text('Mon QR de paiement')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 240,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text("Montrez ce QR au Drive pour payer depuis votre solde."),
            const SizedBox(height: 8),
            const Text("Si solde insuffisant → paiement en caisse ou recharge."),
          ],
        ),
      ),
    );
  }
}
