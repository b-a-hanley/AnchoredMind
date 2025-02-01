import 'package:anchoredmind/components/my_app_bar.dart';
import 'package:anchoredmind/components/my_button.dart';
import '../components/my_colours.dart';
import 'package:anchoredmind/pages/home_page.dart';
import 'package:flutter/material.dart';

class EntryListPage extends StatelessWidget {
  const EntryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: "Entries", context),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: 100, // Number of items
            itemBuilder: (context, index) {
              return Card(
                color: MyColours.lightTeal,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
