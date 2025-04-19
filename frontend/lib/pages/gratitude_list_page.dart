import 'package:flutter/material.dart';
import '../controllers/controller_manager.dart';
import '../controllers/gratitude_controller.dart';
import '../models/gratitude.dart';
import '../pages/gratitude_form.dart';
import '../pages/gratitude_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GratitudeListPage extends StatefulWidget {
  const GratitudeListPage({super.key});

  @override
  GratitudeListPageState createState() => GratitudeListPageState();
}

class GratitudeListPageState extends State<GratitudeListPage> {
  final SearchController searchTEController = SearchController();
  final GratitudeController gratitudeController = ControllerManager.instance.gratitudeController;
  List<Gratitude> gratitudes = [];
  //bool ascending = true;

  @override
  void initState() {
    super.initState();
    gratitudes = gratitudeController.getAll();
    searchTEController.addListener(search);
  }

  search() {
    setState(() {
      gratitudes = gratitudeController.search(searchTEController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.gratitude),
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
                itemCount: gratitudes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColours.lightTeal,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(gratitudes[index].prompt),
                      subtitle: Text(gratitudes[index].time),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GratitudePage(index: gratitudes[index].id)),
                        );
                      },
                    )
                    
                  );
                }
              ),
            ),
            MyButton(
              name: AppLocalizations.of(context)!.add,
              icon: Icons.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GratitudeForm()),
                );
              },
            ),
          ],
        ),
    );
  }
}
