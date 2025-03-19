import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {

  static AudioPlayerService? _instance;

  AudioPlayerService._internal();

  factory AudioPlayerService() {
    _instance ??= AudioPlayerService._internal();
    return _instance!;
  }

  final AudioPlayer _player = AudioPlayer();

  Duration _audioDuration = Duration.zero;
  String asset = "audio/StillMind4MinuteBodyScan.mp3";
  String name = "Four minute body scan";
  Duration get audioDuration => _audioDuration;
  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;
  Stream<PlayerState> get stateStream => _player.onPlayerStateChanged;

  Future<void> setAudio(String path, String audioName) async {
    _player.stop();
    asset = path;
    name = audioName;
    await _player.play(AssetSource(asset));
  }

  Future<void> play() async {
    if (asset.isEmpty) return;
    if (_player.state == PlayerState.paused) {
      await _player.resume();
    } else if (_player.state == PlayerState.stopped||_player.state == PlayerState.completed) {
      await _player.stop();
      await _player.play(AssetSource(asset));
    } else {
      await  _player.pause();
    }
  }

  Future<void> stop() async {
    if (asset.isEmpty) return;
    await  _player.stop();
  }

  Future<Duration> getCurrentPosition() async {
    return await _player.getCurrentPosition() ?? Duration.zero;
  }

  PlayerState getCurrentState() {
    return _player.state;
  }

  String getName() {
    return name;
  }

  Future<void> seekTo(Duration position) async => await _player.seek(position);

}