import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match The Cards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Match The Cards'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CardModel {
  final String frontImage;
  bool isFaceUp;

  CardModel({required this.frontImage, this.isFaceUp = false});
}

class _MyHomePageState extends State<MyHomePage> {
  List<CardModel> _cards = [];
  int _matchesFound = 0;
  int? _firstCardIndex;
  int? _secondCardIndex;
  final String backImage = 'assets/back.png';

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    List<String> images = [
      'assets/Rafael.jpg',
      'assets/Palmer.jpg',
      'assets/Jude.jpg',
      'assets/Lamine.png',
      'assets/Neymar.jpg',
      'assets/Mbappe.jpg',
      'assets/Ronaldo.jpg',
      'assets/Messi.jpg',
      'assets/Rafael.jpg',
      'assets/Palmer.jpg',
      'assets/Jude.jpg',
      'assets/Lamine.png',
      'assets/Neymar.jpg',
      'assets/Mbappe.jpg',
      'assets/Ronaldo.jpg',
      'assets/Messi.jpg',
    ];
    images.shuffle();
    _cards = images.map((image) => CardModel(frontImage: image)).toList();
    _matchesFound = 0;
    _firstCardIndex = null;
    _secondCardIndex = null;
  }

  void _flipCard(int index) {
    setState(() {
      if (_firstCardIndex == null) {
        _firstCardIndex = index;
        _cards[index].isFaceUp = true;
      } else if (_secondCardIndex == null) {
        _secondCardIndex = index;
        _cards[index].isFaceUp = true;
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() {
    if (_firstCardIndex != null && _secondCardIndex != null) {
      if (_cards[_firstCardIndex!].frontImage ==
          _cards[_secondCardIndex!].frontImage) {
        _matchesFound += 1;
        _resetSelection();
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _cards[_firstCardIndex!].isFaceUp = false;
            _cards[_secondCardIndex!].isFaceUp = false;
            _resetSelection();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
