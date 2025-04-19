import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../controllers/controller_manager.dart';
import '../controllers/heartrate_controller.dart';
import '../models/heartrate.dart';

class HeartrateListPage extends StatefulWidget {
  const HeartrateListPage({super.key});

  @override
  HeartrateListPageState createState() => HeartrateListPageState();
}

class HeartrateListPageState extends State<HeartrateListPage> {
  final SearchController searchController = SearchController();
  final HeartrateController heartrateController = ControllerManager.instance.heartrateController;
  List<Heartrate> heartrates = [];
  //bool ascending = true;


  @override
  void initState() {
    super.initState();
    heartrates = heartrateController.getAll();
    searchController.addListener(search);
  }

  search() {
    setState(() {
      heartrates = heartrateController.search(searchController.text);
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
              controller: searchController,
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
                itemCount: heartrates.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColours.lightTeal,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(heartrates[index].heartrate),
                      trailing: Text(heartrates[index].time,
                          style:
                              TextStyle(fontSize: 18, color: MyColours.black)),
                      
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
