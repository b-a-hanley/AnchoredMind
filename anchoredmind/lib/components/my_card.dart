import 'package:flutter/material.dart';
import '../components/my_colours.dart';

class MyCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final GestureTapCallback? onPressed;
  final Color colour;
  final int width;

  // Constructor
  const MyCard({
    super.key,
    required this.name,
    required this.icon,
    this.onPressed, 
    this.colour = MyColours.teal,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, 
      child: Container(
    //todo box shadow
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 32.0, 
                ),
              ),
              Icon(
                icon, 
                size: 100, 
              ),
            ],
          ),
        ),
    );
  }
}