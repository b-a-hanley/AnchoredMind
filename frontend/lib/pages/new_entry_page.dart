import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: "New Entry", context),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: MyColours.teal,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(

          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
            Text(
              'Title',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,// Make the text larger
              ),
            ),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Current Title',
              ),
            ),
            Text(
              'Body',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,// Make the text larger
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300.0,
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Current Body',
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
