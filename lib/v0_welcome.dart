import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class V0Welcome extends StatelessWidget {
  const V0Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond marron/sable
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Bienvenue mon ami(e) 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            // QR Code centré
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: QrImageView(
                data: "https://shakir-drive.app/scan", // lien à personnaliser
                version: QrVersions.auto,
                size: 250.0,
              ),
            ),
            const Text(
              "Scannez le QR CODE pour commencer votre aventure Shakir Drive ✨",
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Text(
              "SHAKIR Oriental Restaurant\nDepuis 1976",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
