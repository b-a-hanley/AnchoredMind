import 'package:flutter/material.dart';
import 'package:frontend/services/local_db_service.dart';
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
  final SearchController searchController = SearchController();
  final localDbService = LocalDBService.instance;
  List<Gratitude> gratitudes = [];
  //bool ascending = true;

  @override
  void initState() {
    super.initState();
    gratitudes = localDbService.getAllGratitudes();
    searchController.addListener(search);
  }

  search() {
    setState(() {
      gratitudes = localDbService.searchGratitudes(searchController.text);
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
