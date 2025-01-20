import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF306468),
        appBar: AppBar(
          leading: BackButton(),
          title: Row(
            children: <Widget>[
              Text(
                "AnchoredMind                    ",
                textAlign: TextAlign.center,
              ),
              Image.asset("images/logo_clear.png", width: 50, height: 50)
            ],
          ),
          backgroundColor: Color(0xFFC2F1C8),
        )

        
      );
  }
}
