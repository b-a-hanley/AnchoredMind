import 'package:anchoredmind/components/my_app_bar.dart';
import 'package:anchoredmind/components/my_button.dart';
import 'package:anchoredmind/pages/home_page.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF306468),
      appBar: MyAppBar(name: "Journal", context),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: 100, // Number of items
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFFB2DFDB),
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: ListTile(
                  title: Text("The day of the woods"),
                  subtitle: Text("11/12/2024"),
                  trailing: Icon(Icons.delete),
                  onTap: () {
                    // Example: Navigate to another page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              );
            }),
          ),
          MyButton(name: "Add new", icon: Icons.add)
        ],
        
      ),
    );
  }
}
