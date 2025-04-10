class CustomFeedback {
  List<int> pattern =[];
  List<int> intensities= [];

  List<int> getPattern() {return pattern;}
  List<int> getIntensities() {return intensities;}
}

class Queen extends CustomFeedback {
  Queen() {
    pattern =     [300, 226, 300, 226, 300, 226, 300, 226, 127, 76, 127, 76, 127, 76, 80, 26, 80, 26, 500, 26, 127, 76, 80, 26, 80, 26];
    intensities = [  0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255];
  }
}

class Waves extends CustomFeedback {
  Waves() {
    pattern =     [100, 900, 100, 900, 100, 900, 100, 900];
    intensities = [  0, 255,   0, 255,   0, 255,   0, 255];
  }
}

class Heartbeat extends CustomFeedback {
  Heartbeat() {
    pattern =     [700, 200, 700, 200, 700, 200, 700, 200, 700, 200, 700, 200];
    intensities = [  0, 255,   0, 255,   0, 255,   0, 255,   0, 255,   0, 255];
  }
}

class Jazz extends CustomFeedback {
  Jazz() {
    pattern =     [200, 200, 600, 300, 200, 200, 600, 300, 200, 200, 600, 300];
    intensities = [  0, 255,   0, 255,   0, 255,   0, 255,   0, 255,   0, 255,   0];
  }
}
