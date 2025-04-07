import 'package:flutter/material.dart';
import 'package:frontend/services/json_service.dart';
import 'gratitude_form.dart';
import '../pages/gratitude_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_button.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GratitudeListPage extends StatefulWidget {
  const GratitudeListPage({super.key});

  @override
  GratitudeListPageState createState() => GratitudeListPageState();
}

class GratitudeListPageState extends State<GratitudeListPage> {
  final jsonService = JsonService();
  late Future<int> gratitudeLength;

  @override
  void initState() {
    super.initState();
    gratitudeLength = jsonService.getGratitudeLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.gratitude),
      body: Column(
          children: [
            Expanded(
              child: FutureBuilder<int>(
                future: gratitudeLength,
                builder: (context, lengthSnapshot) {
                  if (lengthSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (lengthSnapshot.hasError) {
                    return Center(child: Text("Error loading entries."));
                  } else if (!lengthSnapshot.hasData ||
                      lengthSnapshot.data == 0) {
                    return Center(child: Text("No entries available."));
                  }

                  int itemCount = lengthSnapshot.data!;

                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      return Card(
                        color: MyColours.lightTeal,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: jsonService.getGratitude(index),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text("Loading..."),
                                subtitle: Text("Loading..."),
                              );
                            } else if (snapshot.hasError) {
                              return ListTile(
                                title: Text("Error loading gratitude"),
                                subtitle: Text("Please try again later."),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return ListTile(
                                title: Text("No gratitude found"),
                                subtitle: Text("No mood data available."),
                              );
                            }

                            String title =
                                snapshot.data!["prompt"] ?? "Untitled prompt";
                            String gratitude =
                                snapshot.data!["gratitude"] ?? "Unknown gratitude";
                            String date =
                                snapshot.data!["time"] ?? "Unknown time";

                            return ListTile(
                              title: Text(title),
                              subtitle: Text(date),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GratitudePage(index: index)),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            MyButton(
              name: AppLocalizations.of(context)!.addNew,
              icon: Icons.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GratitudeForm()),
                );
              },
            ),
          ],
        ),

    );
  }
}
