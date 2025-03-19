import 'package:flutter/material.dart';
import 'package:frontend/services/json_service.dart';
import '../pages/new_journal_page.dart';
import '../pages/journal_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  _JournalListPageState createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  final jsonService = JsonService();
  late Future<int> gratitudeLengthFuture;

  @override
  void initState() {
    super.initState();
    gratitudeLengthFuture = jsonService.getJournalLength(); // Fetch gratitude length on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<int>(
              future: gratitudeLengthFuture, // Fetch the gratitude length asynchronously
              builder: (context, lengthSnapshot) {
                if (lengthSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching length
                } else if (lengthSnapshot.hasError) {
                  return Center(child: Text("Error loading entries.")); // Error message
                } else if (!lengthSnapshot.hasData || lengthSnapshot.data == 0) {
                  return Center(child: Text("No entries available.")); // No entries message
                }

                // Once length is fetched, proceed with loading gratitude entries
                int itemCount = lengthSnapshot.data!;

                return ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Card(
                      color: MyColours.lightTeal,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: jsonService.getJournal(index), // Fetch gratitude gratitude asynchronously
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return ListTile(
                              title: Text("Loading..."), // Placeholder text while loading
                              subtitle: Text("Loading..."),
                              trailing: Icon(Icons.delete),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text("Error loading gratitude"),
                              subtitle: Text("Please try again later."),
                              trailing: Icon(Icons.delete),
                            );
                          } else if (!snapshot.hasData || snapshot.data == null) {
                            return ListTile(
                              title: Text("No gratitude found"),
                              subtitle: Text("No mood data available."),
                              trailing: Icon(Icons.delete),
                            );
                          }

                          String title = snapshot.data!["title"] ?? "Untitled Gratitude";
                          String mood = snapshot.data!["mood"] ?? "Unknown Mood";

                          return ListTile(
                            title: Text(title),
                            subtitle: Text(mood),
                            trailing: Icon(Icons.delete),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => JournalPage()),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          MyButton(
            name: AppLocalizations.of(context)!.addNew,
            icon: Icons.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewJournalForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
