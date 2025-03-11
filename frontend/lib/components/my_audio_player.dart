import 'package:flutter/material.dart';
import '../components/my_colours.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/audio_player_service.dart';

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({super.key});

  @override
  State<MyAudioPlayer> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<MyAudioPlayer> {
  Duration _currentDuration = Duration.zero;
  Duration _audioDuration = Duration.zero;
  bool _isPlaying = false;
  final audioPlayer = AudioPlayerService();
  @override
  void initState() {
    super.initState();

    audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentDuration = position;
        });
      }
    });

    audioPlayer.durationStream.listen((position) {
      if (mounted) {
        setState(() {
          _audioDuration = position;
        });
      }
    });

    audioPlayer.stateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

  }

  String _formatTime(double value) {
    int minutes = value ~/ 60;
    int seconds = (value % 60).toInt();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              icon: Icon(Icons.replay_10, size: 40),
              onPressed: () async {
                final currentPosition = await audioPlayer.getCurrentPosition();
                await audioPlayer.seekTo(Duration(milliseconds: currentPosition.inMilliseconds - 10000));
              },
            ),
            IconButton(
              icon: Icon(
                (_isPlaying) ? Icons.stop_circle : Icons.play_circle,
                size: 40,
              ),
              onPressed: () {
                audioPlayer.play();
              },
            ),
            IconButton(
              icon: Icon(Icons.forward_10, size: 40),
              onPressed: () async {
                final currentPosition = await audioPlayer.getCurrentPosition();
                await audioPlayer.seekTo(Duration(milliseconds: currentPosition.inMilliseconds + 10000));
              },
            )
          ]),
          Row(
            children: [
              Text(_formatTime(_currentDuration.inSeconds.toDouble())),
              Expanded(
                flex: 2,
                child: Slider(
                value: _currentDuration.inSeconds.toDouble(),
                max: _audioDuration.inSeconds.toDouble(),
                label: _formatTime(_currentDuration.inSeconds.toDouble()),
                thumbColor: MyColours.backgroundGreen,
                activeColor: MyColours.darkTeal,
                inactiveColor: MyColours.black,
                onChanged: (double value) {
                  setState(() {
                    audioPlayer.seekTo(Duration(seconds: value.toInt()));
                    _currentDuration = Duration(seconds: value.toInt());
                  });
                },
              ),),
              Text(_formatTime(_audioDuration.inSeconds.toDouble())),
          ]),
        ]),
      ),
    );
  }
}