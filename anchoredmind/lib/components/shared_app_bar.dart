import 'package:flutter/material.dart';

class SharedAppBar extends AppBar {
  final String name;
  // Constructor
  SharedAppBar({
    super.key,
    required this.name,
  }) : super(
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
        );
}
