import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frontend/services/heartrate_service.dart';
import '../components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/localeprovider.dart';
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
  StreamSubscription? scanSubscription;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  @override
  void dispose() {
    heartrateService.stopScan();
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
            ],
          ),
        ),
      ),
    );
  }
}
