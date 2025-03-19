import '../components/my_app_bar.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
  
class BreathPage extends StatefulWidget {
  @override
  _BreathPageState createState() => _BreathPageState();
}

class _BreathPageState extends State<BreathPage> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(
        "assets/videos/breath.mp4",
      )..setLooping(true),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context, name: AppLocalizations.of(context)!.breath),
        body: Expanded(
          child:  FlickVideoPlayer(flickManager: flickManager),
        ),
      );
  }
}
