import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: "New Entry", context),
      body: Column(
        children: [
          Text("Title"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Current Title',
            ),
          ),
          Text("Body"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Current Body',
            ),
          ),
          MyButton(name: "Add new", icon: Icons.add)
        ],
      ),
    );
  }
}
