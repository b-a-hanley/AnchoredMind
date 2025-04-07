import '../components/my_app_bar.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
  
class BreathPage extends StatefulWidget {
  @override
  BreathPageState createState() => BreathPageState();
}

class BreathPageState extends State<BreathPage> {
  FlickManager? flickManager;
  Object error ={};
  bool _error =false;

  @override
  void initState() {
    super.initState();
    try {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.asset(
          "assets/videos/breath.mp4",
        )..setLooping(true),
      );
    } catch (e) {
      debugPrint("Video init error: $e");
      setState(() {
        error = e;
        _error = true;
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
          Expanded(
            child: _error || flickManager == null
              ? Center(child: Text(error.toString(), style: TextStyle(fontSize: 18)))
              : FlickVideoPlayer(flickManager: flickManager!),
          ),
        ],
      ),
    );
  }
}
