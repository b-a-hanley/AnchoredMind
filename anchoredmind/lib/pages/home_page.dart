import '../components/menu_card.dart';
import '../components/shared_app_bar.dart';
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
      appBar: SharedAppBar(name: "AnchoredMind"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0), // Vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Todo width 2 MenuCard
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                Text(
                  'Feel',
                  style: TextStyle(
                    fontSize: 32.0, // Make the text larger
                  ),
                ),
                Image.asset("images/logo_clear.png", width: 150, height: 150),
              ]),
            ),
            Flexible(
              // Ensures the GridView takes up the remaining space
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                children: <Widget>[
                  MenuCard(name: "Journal", icon: Icons.edit_document),
                  MenuCard(name: "Gratitude", icon: Icons.health_and_safety),
                  MenuCard(name: "Mindful", icon: Icons.self_improvement, colour: Color(0xFF4DB6AC)),
                  MenuCard(name: "Breath", icon: Icons.air, colour: Color(0xFF4DB6AC)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
