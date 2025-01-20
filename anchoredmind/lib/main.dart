import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(AnchoredMind());
}

class AnchoredMind extends StatelessWidget {
  const AnchoredMind({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}