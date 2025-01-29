import 'package:flutter/material.dart';

class MenuCard extends Container {
  final String name;
  final IconData icon;
  final Color colour;
  final int width;
  // Constructor
  MenuCard({
    super.key,
    required this.name,
    required this.icon,
    this.colour = const Color(0xFF80CBC4),
    this.width = 1,
  }) : super(
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
                size: 70, 
              ),
            ],
          ),
        );
}
