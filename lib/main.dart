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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFCB7A2B)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SHAKIR DRIVE')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icon/shakir_drive.png', width: 128, height: 128),
            const SizedBox(height: 16),
            const Text('Version simple prête pour build APK'),
          ],
        ),
      ),
    );
  }
}
