import 'package:flutter/material.dart';
import '../controllers/action_controller.dart';
import '../controllers/controller_manager.dart';
import '../components/my_app_bar.dart';
import '../models/page_action.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActionListPage extends StatefulWidget {
  const ActionListPage({super.key});

  @override
  ActionListPageState createState() => ActionListPageState();
}

class ActionListPageState extends State<ActionListPage> {
  final SearchController searchController = SearchController();
  final ActionController actionController = ControllerManager.instance.actionController;
  List<PageAction> actions = [];
  //bool ascending = true;

  @override
  void initState() {
    super.initState();
    actions = actionController.getAll();
    searchController.addListener(search);
  }

  search() {
    setState(() {
      actions = actionController.search(searchController.text);
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
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColours.lightTeal,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(actions[index].action),
                      trailing: Text(actions[index].time,
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
