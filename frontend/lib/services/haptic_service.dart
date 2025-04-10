import 'package:frontend/objects/custom_feedback.dart';
import 'package:vibration/vibration.dart';

class HapticService {

  static HapticService? _instance;

  HapticService._internal();

  factory HapticService() {
    _instance ??= HapticService._internal();
    return _instance!;
  }

  String asset = "";
  String name = "";
  List<int> pattern = [];
  List<int> intensities = [];
  List<int> timeStamps = [];

  Future<void> setHaptic(CustomFeedback haptic) async {
    pattern = haptic.getPattern();
    intensities = haptic.getIntensities();
  }

  Future<void> play(chosenIntensity) async {
    if (await Vibration.hasVibrator()) { 
      Vibration.vibrate(
        pattern: pattern, 
        intensities: intensities.map((indexIntensity) => indexIntensity ~/(chosenIntensity*100)).toList()
      );
    }
  }

  List<int> getIntensities() {
    return intensities;
  }
  
  List<int> getPattern() {
    return pattern;
  }

  Future<void> stop() async {
    Vibration.cancel();
  }

}