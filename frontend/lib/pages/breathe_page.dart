import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import '../components/my_app_bar.dart';

class BreathePage extends StatefulWidget {
  @override
  BreathePageState createState() => BreathePageState();
}

class BreathePageState extends State<BreathePage> {
  FlickManager? flickManager;
  Object error = {};

  @override
  void initState() {
    super.initState();
    try {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.asset(
          "assets/videos/breathe.mp4", //set breathe video
        )..setLooping(true), //always loop video              
      );
    } catch (e) {
      debugPrint("Video init error: $e");
      setState(() {
        error = e;
      });
    }
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.breath),
      body: Column(
        children: [
          Expanded( //expanded allows the video to take up full screen
            child: error == {} || flickManager == null 
              ? Center(child: Text(error.toString(), style: TextStyle(fontSize: 18)))
              : FlickVideoPlayer(flickManager: flickManager!),
          ),
        ],
      ),
    );
  }
}
