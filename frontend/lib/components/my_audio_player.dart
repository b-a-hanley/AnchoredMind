import 'package:flutter/material.dart';
import '../components/my_colours.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/audio_player_service.dart';

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({super.key});

  @override
  State<MyAudioPlayer> createState() => MyAudioPlayerState();
}

class MyAudioPlayerState extends State<MyAudioPlayer> {
  final audioPlayer = AudioPlayerService();
  
  Duration currentDuration = Duration.zero;
  Duration audioDuration = Duration.zero;
  bool isPlaying = false;
  String audioName = "";
  
  @override
  void initState() {
    super.initState();
    
    audioName = audioPlayer.getName;

    audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          currentDuration = position;
        });
      }
    });

    audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          audioDuration = duration;
        });
      }
    });

    audioPlayer.stateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

  }

  String _formatTime(double value) {
    int minutes = value ~/ 60;
    int seconds = (value % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

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
          Text(
            audioName,
            style: TextStyle(fontSize: 20),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              icon: Icon(Icons.replay_10, size: 40),
              onPressed: () async {
                final currentPosition = await audioPlayer.currentPosition;
                await audioPlayer.seekTo(Duration(milliseconds: currentPosition.inMilliseconds - 10000));
              },
            ),
            IconButton(
              icon: Icon(
                (isPlaying) ? Icons.pause_circle : Icons.play_circle,
                size: 40,
              ),
              onPressed: () {
                audioPlayer.playButton();
              },
            ),
            IconButton(
              icon: Icon(Icons.forward_10, size: 40),
              onPressed: () async {
                final currentPosition = await audioPlayer.currentPosition;
                await audioPlayer.seekTo(Duration(milliseconds: currentPosition.inMilliseconds + 10000));
              },
            )
          ]),
          Row(
            children: [
              Text(_formatTime(currentDuration.inSeconds.toDouble())),
              Expanded(
                flex: 2,
                child:
                  Slider(
                  value: currentDuration.inSeconds.toDouble(),
                  max: audioDuration.inSeconds.toDouble()+2,
                  label: _formatTime(currentDuration.inSeconds.toDouble()),
                  thumbColor: MyColours.backgroundGreen,
                  activeColor: MyColours.darkTeal,
                  inactiveColor: MyColours.black,
                  onChanged: (double value) {
                    setState(() {
                      audioPlayer.seekTo(Duration(seconds: value.toInt()));
                      currentDuration = Duration(seconds: value.toInt());
                    });
                  },
                ),
              ),
              Text(_formatTime(audioDuration.inSeconds.toDouble())),
          ]),
        ]),
      ),
    );
  }
}