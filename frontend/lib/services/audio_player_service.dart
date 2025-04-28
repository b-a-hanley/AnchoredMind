import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {

  static AudioPlayerService? _instance;

  AudioPlayerService._internal();

  factory AudioPlayerService() {
    _instance ??= AudioPlayerService._internal();
    return _instance!;
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  String _asset = "audio/StillMind4MinuteBodyScan.mp3";
  String _name = "Four minute body scan";
  Stream<Duration> get positionStream => audioPlayer.onPositionChanged;
  Stream<Duration> get durationStream => audioPlayer.onDurationChanged;
  Stream<PlayerState> get stateStream => audioPlayer.onPlayerStateChanged;
  //set up new audio including path
  Future<void> setAudio(String path, String audioName) async {
    audioPlayer.stop();
    _asset = path;
    _name = audioName;
  }
  //for the my_audio_player button
  Future<void> playButton() async {
    if (audioPlayer.state == PlayerState.paused) {
      await audioPlayer.resume();
    } else if (audioPlayer.state == PlayerState.stopped||audioPlayer.state == PlayerState.completed) {
      playStart();
    } else {
      await  audioPlayer.pause();
    }
  }
  //simple play
  Future<void> playStart() async {
    if (_asset.isEmpty) return;
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(_asset));
  }
  //stop audio
  Future<void> stop() async {
    if (_asset.isEmpty) return;
    await audioPlayer.stop();
  }
  //get current duration of the audio
  Future<Duration> get currentPosition async => await audioPlayer.getCurrentPosition() ?? Duration.zero;
  PlayerState get currentState => audioPlayer.state; //stop pause play completed
  String get getName => _name; //get name
  Future<void> seekTo(Duration position) async => await audioPlayer.seek(position); //seek by given amount

}