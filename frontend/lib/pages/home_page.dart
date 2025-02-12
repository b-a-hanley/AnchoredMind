import '../pages/feel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/pages/entry_list_page.dart';
import '/pages/mindful_page.dart';
import '/pages/breath_page.dart';
import '../components/my_card.dart';
import '../components/my_colours.dart';
import '../components/my_app_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: "AnchoredMind", context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0), // Vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Todo width 2 MenuCard
          GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeelPage()),
            );
          },
          child:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
              decoration: BoxDecoration(
                color: MyColours.lightTeal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.feel,
                    style: TextStyle(
                      fontSize: 32.0, // Make the text larger
                    ),
                  ),
                  Image.asset("assets/images/logo_clear.png", width: 150, height: 150),
                ]),
            ),),
            Flexible(
              // Ensures the GridView takes up the remaining space
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,

                children: <Widget>[
                  MyCard(name: AppLocalizations.of(context)!.mindful, icon: Icons.self_improvement,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MindfulPage()),
                      );
                    },
                  ),
                  MyCard(name: AppLocalizations.of(context)!.breath, icon: Icons.air,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BreathPage()),
                      );
                    },
                  ),
                  MyCard(name: AppLocalizations.of(context)!.journal, icon: Icons.edit_document, colour: MyColours.darkTeal,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EntryListPage()),
                      );
                    },
                  ),
                  MyCard(name: AppLocalizations.of(context)!.gratitude, icon: Icons.health_and_safety, colour: MyColours.darkTeal,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EntryListPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
