import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {

  static AudioPlayerService? _instance;

  AudioPlayerService._internal();

  factory AudioPlayerService() {
    _instance ??= AudioPlayerService._internal();
    return _instance!;
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  Duration _audioDuration = Duration.zero;
  String asset = "audio/StillMind4MinuteBodyScan.mp3";
  String name = "Four minute body scan";
  Duration get audioDuration => _audioDuration;
  Stream<Duration> get positionStream => audioPlayer.onPositionChanged;
  Stream<Duration> get durationStream => audioPlayer.onDurationChanged;
  Stream<PlayerState> get stateStream => audioPlayer.onPlayerStateChanged;

  Future<void> setAudio(String path, String audioName) async {
    audioPlayer.stop();
    asset = path;
    name = audioName;
    await audioPlayer.play(AssetSource(asset));
  }

  Future<void> play() async {
    if (asset.isEmpty) return;
    if (audioPlayer.state == PlayerState.paused) {
      await audioPlayer.resume();
    } else if (audioPlayer.state == PlayerState.stopped||audioPlayer.state == PlayerState.completed) {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(asset));
    } else {
      await  audioPlayer.pause();
    }
  }

  Future<void> stop() async {
    if (asset.isEmpty) return;
    await  audioPlayer.stop();
  }

  Future<Duration> getCurrentPosition() async {
    return await audioPlayer.getCurrentPosition() ?? Duration.zero;
  }

  PlayerState getCurrentState() {
    return audioPlayer.state;
  }

  String getName() {
    return name;
  }

  Future<void> seekTo(Duration position) async => await audioPlayer.seek(position);

}