import 'card_choice_page.dart';

MaterialApp(
  title: 'Shakir Drive',
  theme: ThemeData(primarySwatch: Colors.brown),
  home: const HomePage(),
  routes: {
    '/card-choice': (context) => const CardChoicePage(),
  },
);
