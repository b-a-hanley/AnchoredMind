import '../components/my_app_bar.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BreathPage extends StatelessWidget {
  BreathPage({super.key});

  final FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.asset("assets/videos/test1.mp4"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.breath),
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
      ),
    );
  }
}