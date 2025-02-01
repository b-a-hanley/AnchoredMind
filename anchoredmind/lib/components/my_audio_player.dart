import 'package:flutter/material.dart';
import '../components/my_colours.dart';

class MyAudioPlayer extends StatelessWidget {
  // Constructor
  const MyAudioPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: MyColours.primary,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Icon(Icons.replay_10, size: 40),
            Icon(Icons.play_circle, size: 40),
            Icon(Icons.forward_10, size: 40),
          ]),
          Slider(
            value: 50,
            max: 100,
            divisions:100,
            label: "Slider",
            thumbColor: MyColours.backgroundGreen,
            activeColor: MyColours.darkTeal,
            inactiveColor: MyColours.black,
            onChanged: (double value) {
              
            },
          ),
        ]),
      ),
    );
  }
}
