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
      body: 
      Flexible(
              // Ensures the GridView takes up the remaining space
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,

                children: <Widget>[
                  MyCard(name: "Funk", icon: Icons.play_arrow,
                    onPressed: () {
                      anotherOneBitesTheDust();
                    }
                  ),
                  MyCard(name: "Waves", icon: Icons.play_arrow,
                    onPressed: () {
                      waves();
                    }
                  ),
                  MyCard(name: "60bpm", icon: Icons.play_arrow,
                    onPressed: () {
                      heartrate();
                    }
                  ),
                ],
              ),
            ),
    );
  }
}

void anotherOneBitesTheDust() async {
  if (await Vibration.hasVibrator() ?? false) {
    List<int> pattern = [
      300, 100, 300, 100, 600, 100, 600, 100, 300, 100, 300, 100, 600, 100, 600
    ];
    List<int> intensities = [
      255, 0, 255, 0, 180, 0, 180, 0, 255, 0, 255, 0, 180, 0, 180
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}

void waves() async {
  if (await Vibration.hasVibrator() ?? false) {
    List<int> pattern = [
      400, 400, 400, 400, 400, 400, 400, 400, 400, 400,400, 400

    ];
    List<int> intensities = [
      255, 150, 0, 150, 255, 150, 0, 150, 255, 150, 0, 150, 255
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}

void heartrate() async {
  if (await Vibration.hasVibrator() ?? false) {
    List<int> pattern = [
      800, 0, 800, 0, 800, 0, 800, 0, 800, 0, 800, 0
    ];
    List<int> intensities = [
      255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0,
    ];

    Vibration.vibrate(pattern: pattern, intensities: intensities);
  }
}
