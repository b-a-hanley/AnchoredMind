import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../services/json_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GratitudePage extends StatefulWidget {
  final int index;

  const GratitudePage({super.key, required this.index});

  @override
  GratitudePageState createState() => GratitudePageState();
}

class GratitudePageState extends State<GratitudePage> {
  final jsonService = JsonService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.gratitude),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: MyColours.teal,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: 
              FutureBuilder<Map<String, dynamic>>(
                        future: jsonService.getGratitude(index), // Fetch gratitude gratitude asynchronously
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData || snapshot.data == null) {
                            return Text('Error: ${snapshot.error}');
                          }

                          String prompt = snapshot.data!["prompt"] ?? "Unknown prompt";
                          String gratitude = snapshot.data!["gratitude"] ?? "Unknown Gratitude";
                          String time = snapshot.data!["time"] ?? "Unknown Time";

                          return Column(
                            children: [
                            Text(
                              "Prompt",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),Text(
                              prompt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                            Text(
                              "Time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              time,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                            Text(
                              "Gratitude",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              gratitude,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ]);
                        },
                      ),
        ),
      ),
    );
  }
}
