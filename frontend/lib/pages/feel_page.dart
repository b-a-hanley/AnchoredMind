import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_card.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vibration/vibration.dart';

class FeelPage extends StatelessWidget {
  const FeelPage({super.key});

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
                anotherOneBitesTheDust();
              }
            ),
            MyCard(
              name: "Waves",
              icon: Icons.waves,
              onPressed: () {
                waves();
              }
            ),
            MyCard(
              name: "Heartbeat",
              icon: Icons.monitor_heart_outlined,
              onPressed: () {
                heartrate();
              }
            ),
            MyCard(
              name: "Jazz",
              icon: Icons.nightlife,
              onPressed: () {
                jazz();
              }
            ),
          ],
        ),
    );
  }
}

void anotherOneBitesTheDust() async {
  if (await Vibration.hasVibrator()) {
    List<int> pattern = [
      300, 226, 300, 226, 300, 226, 300, 226, 127, 76, 127, 76, 127, 76, 80, 26, 80, 26, 500, 26, 127, 76, 80,
      26, 80, 26, 300, 226, 300, 226, 300, 226, 300, 226, 127, 76, 127, 76, 127, 76, 80, 26, 80, 26, 500, 26, 
      127, 76, 80, 26, 80, 26, 300, 226, 300, 226, 300, 226, 300, 226, 127, 76, 127, 76, 127, 76, 80, 26, 80, 
      26, 500, 26, 127, 76, 80, 26, 80, 26, 300, 226, 300, 226, 300, 226, 300, 226, 127, 76, 127, 76, 127, 76,
      80, 26, 80, 26, 500, 26, 127, 76, 80, 26, 80, 26,
    ];
    List<int> intensities = [
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}

void waves() async {
  if (await Vibration.hasVibrator()) {
    List<int> pattern = [
      100, 900, 100, 900, 100, 900, 100, 900, 100, 900, 100, 900, 100, 900, 100, 
    ];
    List<int> intensities = [
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}

void heartrate() async {
  if (await Vibration.hasVibrator()) {
    List<int> pattern = [
      700, 200, 700, 200, 700, 200, 700, 200, 700, 200, 700, 200, 700, 200, 700,
    ];
    List<int> intensities = [
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}

void jazz() async {
  if (await Vibration.hasVibrator()) {
    List<int> pattern = [
      200, 200, 600, 300, 200, 200, 600, 300, 200, 200, 600, 300, 200, 200, 600, 300, 200, 200, 600, 300, 200, 200,
      600, 300, 200, 200, 600, 300, 200, 200, 600, 300,
    ];
    List<int> intensities = [
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}
