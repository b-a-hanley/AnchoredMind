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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0), // Vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Journal',
                          style: TextStyle(
                            fontSize: 32.0, // Make the text larger
                          ),
                        ),
                        Icon(
                          Icons.edit_document, // The icon to display
                          size: 70, // Optional: size of the icon
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Gratitude',
                          style: TextStyle(
                            fontSize: 32.0, // Make the text larger
                          ),
                        ),
                        Icon(
                          Icons.health_and_safety, // The icon to display
                          size: 70, // Optional: size of the icon
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Mindful',
                          style: TextStyle(
                            fontSize: 32.0, // Make the text larger
                          ),
                        ),
                        Icon(
                          Icons
                              .self_improvement_outlined, // The icon to display
                          size: 70, // Optional: size of the icon
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Breath',
                          style: TextStyle(
                            fontSize: 32.0, // Make the text larger
                          ),
                        ),
                        Icon(
                          Icons.air, // The icon to display
                          size: 70, // Optional: size of the icon
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
