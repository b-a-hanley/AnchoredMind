import 'package:flutter/material.dart';
import '../pages/new_entry_page.dart';
import '../pages/entry_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EntryListPage extends StatelessWidget {
  const EntryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
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
                      MaterialPageRoute(builder: (context) => EntryPage()),
                    );
                  },
                ),
              );
            }),
          ),
          MyButton(name: AppLocalizations.of(context)!.addNew, icon: Icons.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewEntryPage()),
              );
            },
          )
        ],
        
      ),
    );
  }
}
