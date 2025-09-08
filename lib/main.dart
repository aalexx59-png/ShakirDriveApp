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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
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
            Image.asset('assets/icon/shakir_drive.png', width: 160, height: 160),
            const SizedBox(height: 16),
            const Text('Bienvenue sur SHAKIR DRIVE'),
          ],
        ),
      ),
    );
  }
}
