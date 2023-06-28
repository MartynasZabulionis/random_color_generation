import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_color_generation/animated_colored_box.dart';

/// The main app widget
class App extends StatelessWidget {
  /// The default constructor that take nothing but key
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Material(child: HomePage()),
    );
  }
}

/// The home page
class HomePage extends StatefulWidget {
  /// Default constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _backgroundColor = ValueNotifier(Colors.white);
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _regenerateColor();
  }

  void _regenerateColor() {
    Color newColor;
    const minRGBValue = 20;
    const maxRGBValue = 0xFF;
    do {
      newColor = Color.fromARGB(
        maxRGBValue,
        _random.nextInt(maxRGBValue),
        _random.nextInt(maxRGBValue),
        _random.nextInt(maxRGBValue),
      );
    } while (newColor.blue < minRGBValue &&
        newColor.green < minRGBValue &&
        newColor.red < minRGBValue);
    _backgroundColor.value = newColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _regenerateColor,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: ValueListenableBuilder(
              valueListenable: _backgroundColor,
              builder: (context, color, child) {
                return AnimatedColoredBox(color: color);
              },
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Hello there',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _backgroundColor.dispose();
    super.dispose();
  }
}
