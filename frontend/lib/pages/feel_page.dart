import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/my_colours.dart';
import '../components/my_app_bar.dart';
import '../controllers/action_controller.dart';
import '../controllers/controller_manager.dart';
import '../services/audio_player_service.dart';
import '../services/haptic_service.dart';


class FeelPage extends StatefulWidget {
  const FeelPage({super.key});

  @override
  FeelPageState createState() =>
      FeelPageState(); // Returning the state of the widget
}

class FeelPageState extends State<FeelPage> {
  final hapticService = HapticService();
  final ActionController actionController = ControllerManager.instance.actionController;
  final audioService = AudioPlayerService();
  List<int> pattern = [];
  List<int> intensities = [];
  List<FlSpot> graphData = [];
  int currentDuration = 0;
  String patternString = "";
  String intensitiesString = "";
  int sum = 0;
  double chosenIntensity = 100;
  bool loopingOn = false;
  bool isPlaying = false;
  bool audioOn = true;

  @override
  void initState() {
    super.initState();
    audioService.setAudio("audio/anchoredmind.mp3", "anchoredmind");
    pattern = hapticService.getPattern();
    intensities = hapticService.getIntensities();
    combineData(pattern, intensities);
  }

  void graphUpdate() {
    sum = pattern.sublist(0, pattern.length - 1).reduce((a, b) => a + b);
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 200));
      bool isFinished = false;
      setState(() {
        if (currentDuration < sum) {
          currentDuration += 200;
        } else {
          currentDuration = 0;
          isFinished = true;
        }
      });
      if (isFinished&&loopingOn) {
        hapticService.play(chosenIntensity);
        if (audioOn) audioService.playStart();
        actionController.putActionStr("feel.${hapticService.id}.loop");
      }
      if (isFinished&&!loopingOn||!isPlaying) {
        isPlaying=false;
        currentDuration=0;
        audioService.stop();
        return false;
      }
      return true;
    });
  }
  //translates the haptic data to data points for graph
  void combineData(List<int> pattern, List<int> intensities) {
    sum = 0;
    for (int i = 0; i < pattern.length; i++) {
      if (i > 0) {
        sum = pattern.sublist(0, i).reduce((a, b) => a + b);
      }//add all previous values and generate list
      //add start of duration
      graphData.add(FlSpot(sum.toDouble(), (intensities[i].toDouble() / 255 * 100)));
      //add end of duration
      graphData.add(FlSpot(sum.toDouble() + pattern[i].toDouble() - 1, (intensities[i].toDouble() / 255 * 100)));
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioService.stop();
    hapticService.stop();
    actionController.putActionStr("feel.${hapticService.id}.leave");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.feel),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 0.6, //proportions of graph
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles( //horizontal seconds title
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 500, //0.5 seconds
                      getTitlesWidget: (value, meta) => Text(
                          '${value.toInt() / 1000} s', //display seconds scale
                          style: TextStyle(fontSize: 10, color: MyColours.white)),
                    ),
                  ),
                  leftTitles: AxisTitles(//vertical haptic % title
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20, //20%
                      getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}%',//percent scale
                          style: TextStyle(fontSize: 10, color: MyColours.white)),
                    ),
                  ),
                  topTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true, //graph perimeter colour
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                minY: 0, //min percent of haptic
                maxY: 100, //max percent of haptic
                lineBarsData: [
                  LineChartBarData( 
                    spots: graphData, //uses graph data
                    barWidth: 3,
                    color: Colors.white,
                    belowBarData: BarAreaData( //have faint colouring of bars
                      show: true,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine( //moving vertical line showing current point in haptic
                      x: currentDuration.toDouble(), 
                      color: MyColours.black,
                      strokeWidth: 2,
                      dashArray: [5, 5],
                      label: VerticalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        style: TextStyle(color: MyColours.white, fontSize: 10),
                        labelResolver: (line) => '${currentDuration / 1000} s',
                      ), //describes current seconds
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Text(patternString),
        // Text(intensitiesString),
        Container(
          margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: MyColours.primary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(children: [
            // Slider(
            //   value: chosenIntensity,
            //   min: 0,
            //   max: 100,
            //   label: "$chosenIntensity%",
            //   thumbColor: MyColours.backgroundGreen,
            //   activeColor: MyColours.darkTeal,
            //   inactiveColor: MyColours.black,
            //   onChanged: (double value) {
            //     setState(() {
            //       chosenIntensity = value;
            //     });
            //   },
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                icon: Icon(
                  (audioOn) ? Icons.volume_up : Icons.volume_off,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    audioOn = !audioOn;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  (isPlaying) ? Icons.stop_circle : Icons.play_circle,
                  size: 40,
                ),
                onPressed: () {
                  isPlaying = !isPlaying;
                  if (isPlaying) {
                    hapticService.play(chosenIntensity);
                    currentDuration=0;
                    actionController.putActionStr("feel.${hapticService.getId()}.play");
                    graphUpdate();
                    if (audioOn) audioService.playStart();
                  }
                  else {
                    currentDuration=0;
                    audioService.stop();
                    hapticService.stop();
                    actionController.putActionStr("feel.${hapticService.getId()}.stop");
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  (!loopingOn) ? Icons.repeat : Icons.repeat_on,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                  loopingOn = !loopingOn;
                  });
                },
              )
            ]),
          ]),
        ),
      ]),
    );
  }
}
