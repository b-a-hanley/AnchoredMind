import 'package:flutter/material.dart';
import '../services/audio_player_service.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../components/my_audio_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MindfulPage extends StatelessWidget {
  MindfulPage({super.key});
  final audioPlayer = AudioPlayerService();
  final audioData = [
    [
      "Ten minute minfulness of breathing",
      "Padraig O'Morain",
      "10:01",
      "audio/PadraigTenMinuteMindfulnessOfBreathing.mp3"
    ],
    [
      "Four minute body scan",
      "Melbourne Mindfulness Centre & Still Mind",
      "4:01",
      "audio/StillMind4MinuteBodyScan.mp3"
    ],
    [
      "Ten minute wisdom meditation",
      "UCSD Center for mindfulness",
      "10:26",
      "audio/UCSD10MinuteWisdom.mp3"
    ],
    [
      "The Tension Release Meditation",
      "Vidyamala Burch, Breathworks",
      "5:45",
      "audio/VidyamalaTensionRelease.mp3"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: AppLocalizations.of(context)!.mindful, context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: audioData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      audioPlayer.setAudio(audioData[index][3],audioData[index][0]);
                      audioPlayer.playButton();
                    },
                    child: Card(
                      color: MyColours.lightTeal,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        title: Text(audioData[index][0]),
                        subtitle: Text(audioData[index][1]),
                        trailing: Text(audioData[index][2],
                            style: TextStyle(
                                fontSize: 20, color: MyColours.black)),
                      ),
                    ),
                  );
                }),
          ),
          MyAudioPlayer()
        ],
      ),
    );
  }
}
