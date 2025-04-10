import 'package:flutter/material.dart';
import '../services/haptic_service.dart';
import '../objects/custom_feedback.dart';
import '../pages/feel_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_card.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeelListPage extends StatelessWidget {
  FeelListPage({super.key});
  final hapticService = HapticService();
  final waves = Waves();
  final queen = Queen();
  final heartbeat = Heartbeat();
  final jazz = Jazz();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: AppLocalizations.of(context)!.feel, context),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: <Widget>[
            MyCard(
              name: "Queen",
              icon: Icons.music_note,
              onPressed: () {
                hapticService.setHaptic(queen);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeelPage()),
                );
              }
            ),
            MyCard(
              name: "Waves",
              icon: Icons.waves,
              onPressed: () {
                hapticService.setHaptic(waves);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeelPage()),
                );
              }
            ),
            MyCard(
              name: "Heartbeat",
              icon: Icons.monitor_heart_outlined,
              onPressed: () {
                hapticService.setHaptic(heartbeat);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeelPage()),
                );
              }
            ),
            MyCard(
              name: "Jazz",
              icon: Icons.nightlife,
              onPressed: () {
                hapticService.setHaptic(jazz);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeelPage()),
                );
              }
            ),
          ],
        ),
    );
  }
}