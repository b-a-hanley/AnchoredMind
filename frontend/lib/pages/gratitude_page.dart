import 'package:flutter/material.dart';
import 'package:frontend/pages/gratitude_list_page.dart';
import 'package:frontend/pages/gratitude_edit_form.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/services/local_db_service.dart';
import '../models/gratitude.dart';

class GratitudePage extends StatefulWidget {
  final int index;

  const GratitudePage({super.key, required this.index});

  @override
  GratitudePageState createState() => GratitudePageState();
}

class GratitudePageState extends State<GratitudePage> {
  final localDbService = LocalDBService.instance;
  int index = 0;
  String prompt = "";
  String entry = "";
  String time = "";

  @override
  void initState() {
    super.initState();
    index = widget.index;
    Gratitude gratitude = localDbService.getGratitude(index);
    prompt = gratitude.prompt;
    entry = gratitude.gratitude;
    time = gratitude.time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.gratitude),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: MyColours.teal,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                children: [
                  Text(
                    "Prompt",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    prompt,
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
                    "Gratitude",
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
                        onPressed:() => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GratitudeEditForm(index: index))
                          )
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(color: MyColours.backgroundGreen),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          localDbService.deleteGratitude(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Gratitude Deleted!")),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GratitudeListPage())
                          );
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: MyColours.backgroundGreen),
                        ),
                      ),
                    ],
                  )
                ]
            ),
          ),

        ],
      )
    );
  }
}
