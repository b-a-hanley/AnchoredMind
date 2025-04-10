import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../services/json_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalPage extends StatefulWidget {
  final int index;

  const JournalPage({super.key, required this.index});

  @override
  JournalPageState createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  final jsonService = JsonService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: MyColours.teal,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: 
            FutureBuilder<Map<String, dynamic>>(
              future: jsonService.getJournal(index), // Fetch gratitude gratitude asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Error: ${snapshot.error}');
                }

                String title = snapshot.data!["title"] ?? "Untitled Gratitude";
                String mood = snapshot.data!["mood"] ?? "Unknown Mood";
                String intensity = snapshot.data!["intensity"] ?? "Unknown Level";
                String time = snapshot.data!["time"] ?? "Unknown Time";
                String journalEntry = snapshot.data!["journalEntry"] ?? "No entry";

                return Column(
                  children: [
                  Text(
                    "Title",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  Text(
                    "Mood",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    "$intensity $mood",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  Text(
                    "Time",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    time,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  Text(
                    "Body",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    journalEntry,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ]
              );
            },
          ),
        ),
      ),
    );
  }
}
