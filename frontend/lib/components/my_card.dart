import 'package:flutter/material.dart';
import '../components/my_colours.dart';

class MyCard extends StatelessWidget {
  final String name;
  final IconData? icon;
  final GestureTapCallback? onPressed;
  final Color colour;
  final int width;

  // Constructor
  const MyCard({
    super.key,
    required this.name,
    this.icon,
    this.onPressed, 
    this.colour = MyColours.teal,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, 
      child: Container(
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
                  fontSize: 28.0,
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