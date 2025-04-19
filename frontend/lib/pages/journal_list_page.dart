import 'package:flutter/material.dart';
import 'package:frontend/controllers/controller_manager.dart';
import 'package:intl/intl.dart';
import '../controllers/journal_controller.dart';
import 'journal_form.dart';
import '../pages/journal_page.dart';
import '../components/my_app_bar.dart';
import '../models/journal.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  JournalListPageState createState() => JournalListPageState();
}

class JournalListPageState extends State<JournalListPage> {
  final SearchController searchTEController = SearchController();
  final JournalController journalController = ControllerManager.instance.journalController;
  List<Journal> journals = [];
  //bool ascending = true;

  @override
  void initState() {
    super.initState();
    journals = journalController.getAll();
    searchTEController.addListener(search);
  }

  search() {
    setState(() {
      journals = journalController.search(searchTEController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SearchBar(
              controller: searchTEController,
              hintText: 'Search here',
              leading: Icon(Icons.search),
              // trailing: [
              //   IconButton(
              //     icon: Icon(Icons.sort),
              //     onPressed: () {
              //       setState(() {
              //         ascending = !ascending;
              //       });
              //       search();
              //     },
              //   ),
              // ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: journals.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColours.lightTeal,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text("${DateFormat('dd/MM').format(journals[index].time as DateTime)} ${journals[index].title}"),
                      trailing: Text(journals[index].mood,
                          style:
                              TextStyle(fontSize: 18, color: MyColours.black)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JournalPage(index: journals[index].id)),
                        );
                      },
                    ),
                  );
                }),
          ),
          MyButton(
            name: AppLocalizations.of(context)!.add,
            icon: Icons.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
