
import 'package:frontend/services/heartrate_service.dart';
import '../components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/localeprovider.dart';
import '../components/my_colours.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  HeartrateService heartrateService = HeartrateService();
  String? selectedDevice;
  late Stream<List<String>> scan;
  
  @override
  void initState() {
    //HeartRateService.instance.scan();
    scan = heartrateService.scan();
    super.initState();
  }

  Future<List<DropdownMenuEntry<String>>> getDeviceDropdownEntries() async {
    final names = await heartrateService.scan().first; // Just wait for first result
    return names.map((name) => DropdownMenuEntry(value: name, label: name)).toList();
  }

  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: "Profile"),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
        color: MyColours.teal,
        borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Text(
              'Language',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,
              )
            ),
            DropdownButton<Locale>(
              value: localeProvider.locale,

              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeProvider.setLocale(newLocale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
                DropdownMenuItem(
                  value: Locale('hi'),
                  child: Text('हिन्दी'),
                ),
                DropdownMenuItem(
                  value: Locale('bn'),
                  child: Text('বাংলা'),
                ),
                DropdownMenuItem(
                  value: Locale('zh'),
                  child: Text('繁體'),
                ),
              ],
            ),
            Text(
                'Heartrate Devices',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.0,
                )
            ),
            StreamBuilder<List<String>>(
                stream: scan,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final deviceNames = snapshot.data!;
                    return DropdownButton<String>(
                      value: selectedDevice,
                      hint: Text('Select a Device'),
                      onChanged: (String? newDevice) {
                        setState(() {
                          selectedDevice = newDevice;
                        });
                      },
                      items: deviceNames
                          .map((deviceName) => DropdownMenuItem<String>(
                                value: deviceName,
                                child: Text(deviceName),
                              ))
                          .toList(),
                    );
                  } else {
                    return Text('No devices found');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}