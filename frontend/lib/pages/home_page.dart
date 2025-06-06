import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/my_app_bar.dart';
import '../components/my_card.dart';
import '../components/my_colours.dart';
import '../pages/breathe_page.dart';
import '../pages/feel_list_page.dart';
import '../pages/journal_list_page.dart';
import '../pages/mindful_page.dart';
import '../pages/gratitude_list_page.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 40.0), // Vertical padding
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Todo width 2 MenuCard
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeelListPage()),
                  );
                },
                child: 
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: MyColours.lightTeal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(children: [
                      Text(
                        AppLocalizations.of(context)!.feel,
                        style: TextStyle(
                          fontSize: 32.0, 
                        ),
                      ),
                      Icon(Icons.vibration, size: 100,)
                    ]),
                  ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  children: <Widget>[
                    MyCard(
                      name: AppLocalizations.of(context)!.mindful,
                      icon: Icons.self_improvement,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MindfulPage()),
                        );
                      },
                    ),
                    MyCard(
                      name: AppLocalizations.of(context)!.breath,
                      icon: Icons.air,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BreathePage()),
                        );
                      },
                    ),
                    MyCard(
                      name: AppLocalizations.of(context)!.journal,
                      icon: Icons.edit_document,
                      colour: MyColours.darkTeal,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JournalListPage()),
                        );
                      },
                    ),
                    MyCard(
                      name: AppLocalizations.of(context)!.gratitude,
                      icon: Icons.health_and_safety,
                      colour: MyColours.darkTeal,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GratitudeListPage()),
                        );
                      },
                    ),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
