import 'dart:async';
import '../pages/action_list_page.dart';
import '../pages/heart_rate_monitor.dart';
import '../pages/heartrate_list_page.dart';
import '../providers/locale_provider.dart';
import '../services/heartrate_service.dart';
import '../components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_colours.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final HeartrateService heartrateService = HeartrateService();
  String? selectedDevice;
  List<String> deviceNames = [];
  bool isScanning = true;
  bool rememberDevice = false;
  StreamSubscription? scanSubscription;

  @override
  void initState() {
    super.initState();
    startScan();
    heartrateService.monitorHeartrate();
  }

  @override
  void dispose() {
    heartrateService.stopScan();
    heartrateService.currentHeartrate.dispose();
    super.dispose();
  }

  void startScan() {
    setState(() {
      deviceNames = [];
    });

    scanSubscription = heartrateService.scan().listen((devices) {
      setState(() {
        deviceNames = devices.where((name) => name.isNotEmpty).toList();
      });
    }, onDone: () {
      setState(() {
        isScanning = false;
      });
    });
  }

  List<DropdownMenuEntry<String>> getDeviceDropdownEntries() {
    return deviceNames
        .map((name) => DropdownMenuEntry(value: name, label: name))
        .toList();
  }

  @override
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
          constraints: BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Language',
                style: TextStyle(fontSize: 24.0),
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
              SizedBox(height: 20),
              Text(
                'Heartrate Devices',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10),
              deviceNames.isEmpty
                ? Center(child: CircularProgressIndicator())
                // : (deviceNames.isEmpty&&!isScanning)
                  // ? GestureDetector(
                  //     onTap: startScan,
                  //     child: Text("No devices found, try again?"),
                  //   )
                  : DropdownMenu<String>(
                    label: Text("Select Heartrate device"),
                    initialSelection: selectedDevice,
                    onSelected: (String? newDevice) {
                      setState(() {
                        selectedDevice = newDevice;
                      });
                      heartrateService.stopScan();
                      if (newDevice != null) {
                        heartrateService
                            .connectToDevice(newDevice)
                            .then((result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result)),
                          );
                        });
                      }
                      
                    },
                    dropdownMenuEntries: getDeviceDropdownEntries(),
                  ),
                (selectedDevice !=null)?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: rememberDevice,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberDevice =!rememberDevice;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Stored heartrate device!")),
                        );
                      },
                    ),
                    Text("Remember this device"),
                  ],
                )
              : SizedBox(height:15),
              ValueListenableBuilder<int>(
                valueListenable: heartrateService.currentHeartrate,
                builder: (context, value, _) {
                  return value > 0
                    ? Text(
                        'Current Heart Rate: $value bpm',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        selectedDevice != null
                          ? 'Waiting for heart rate data...'
                          : 'Connect to a device to see heart rate',
                        style: TextStyle(fontSize: 16),
                      );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActionListPage()));
                    },
                    child: Text(
                      'Actions',
                      style: TextStyle(color: MyColours.backgroundGreen),
                    ),
                  ),

              ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HeartrateListPage()));
                    },
                    child: Text(
                      'Heartrates',
                      style: TextStyle(color: MyColours.backgroundGreen),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HeartRateMonitor()));
                    },
                    child: Text(
                      'Heartrate monitor',
                      style: TextStyle(color: MyColours.backgroundGreen),
                    ),
                  ),
            ],

          ),
        ),
      ),
    );
  }
}
