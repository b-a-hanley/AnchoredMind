import 'package:anchoredmind/components/my_app_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import '../components/my_colours.dart';
import 'package:anchoredmind/components/my_audio_player.dart';
import 'package:anchoredmind/pages/home_page.dart';
import 'package:flutter/material.dart';

class MindfulPage extends StatelessWidget {
  MindfulPage({super.key});
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(name: "Mindful", context),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: 100, // Number of items
            itemBuilder: (context, index) {
              return Card(
                color: MyColours.lightTeal,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: ListTile(
                  title: Text("The day of the woods"),
                  subtitle: Text("11/12/2024"),
                  trailing: Icon(Icons.download),
                  onTap: () {
                    // Example: Navigate to another page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
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
