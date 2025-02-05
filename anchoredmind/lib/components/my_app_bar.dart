import 'package:flutter/material.dart';
import '../components/my_colours.dart';

class MyAppBar extends AppBar {
  final String name;
  final BuildContext context;
  // Constructor
  MyAppBar(this.context, {
    super.key,
    required this.name,
  }) : super(
      automaticallyImplyLeading: false,
      backgroundColor: MyColours.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(onPressed: () {Navigator.pop(context);}),
          Row(
              children: [
                Image.asset("assets/images/logo_clear.png", width: 40, height: 40),
                Text(
                  name,
                  textAlign: TextAlign.center,
                ),
              ],
          ),
          Icon(Icons.person, size: 32,)
        ],
      ),
    );
}
