import 'package:flutter/material.dart';
import 'package:frontend/pages/journal_list_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/services/local_db_service.dart';
import '../models/journal.dart';
import 'journal_form.dart';

class JournalPage extends StatefulWidget {
  final int index;

  const JournalPage({super.key, required this.index});

  @override
  JournalPageState createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  final localDbService = LocalDBService.instance;
  int index = 0;
  String title = "";
  String mood = "";
  String intensity = "";
  String time = "";
  String entry = "";

  @override
  void initState() {
    super.initState();
    index = widget.index;
    Journal journal = localDbService.getJournal(index);
    title = journal.title;
    mood = journal.mood;
    intensity = journal.intensity;
    time = journal.time;
    entry = journal.journal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: MyColours.teal,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Expanded(
            child: Column(children: [
              //Text(index.toString()),
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
                entry,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JournalForm(index: index)))
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(color: MyColours.backgroundGreen),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      localDbService.deleteJournal(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Journal Deleted!")),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JournalListPage()));
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: MyColours.backgroundGreen),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
