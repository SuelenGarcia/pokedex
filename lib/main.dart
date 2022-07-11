import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pokemon_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/pokemonPage': (context) => const PokemonPage(),
      },
      initialRoute: '/',
    );
  }
}
