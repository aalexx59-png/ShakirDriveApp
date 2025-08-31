import 'package:flutter/material.dart';

class V1BisHome extends StatelessWidget {
  const V1BisHome({super.key});

  @override
  Widget build(BuildContext context) {
    const int numeroClient = 1111;

    // Numérologie simple (somme des chiffres)
    final int somme = numeroClient
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFF8B5E3C), // fond sable/marron
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Bienvenue dans la Famille de cœur 💛",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Bloc numéro attribué
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      "🎉 Félicitations 🎉",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Vous êtes le numéro",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      numeroClient.toString(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$somme – Le chiffre de la stabilité et de la force",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Bloc formulaire profil utilisateur
              Column(
                children: const [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Prénom",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Date d’anniversaire 🎂",
                      border: Outline
