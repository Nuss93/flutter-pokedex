import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// Widgets are like components in React
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// defines the app's state
// ChangeNotifier can notify others about its own changes, will notify other widgets
// Ctate is created and provided to the whole app using ChangeNotifierProvider
class MyAppState extends ChangeNotifier {
  // variables in the class state
  var current = WordPair.random();

  void getNext() { // Reassigns current with a new random WordPair
    current = WordPair.random();

    // Call notifyListeners() to ensure anyone watching this widget is notified
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // Every widget defines a build() ethod called every time a widget's circumstances change
    var appState = context.watch<MyAppState>(); // Tracks changes to the app's current state using watch method
    var pair = appState.current;

    return Scaffold( // Every build method must return a widget or a nested tree of widgets. Top-level widget is Scaffold
    // Column is the most basic layout widgets in Flutter
    // Can take any number of children and put them in a column from top to bottom
      body: Column(
        children: [
          Text('An amazing idea:'),
          WordCard(pair: pair),

          ElevatedButton(
            onPressed: () {
              // print('button pressed');
              appState.getNext();
            }, child: Text('Next'))
        ],
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // App requesting the app's current theme

    // theme.textTheme, we are accessing the app's font theme
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card (
      elevation: 15.0,
      color: theme.colorScheme.primary, // Defines the colour set in colorScheme
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(pair.asLowerCase, style: style,),
      ),
    );
  }
}