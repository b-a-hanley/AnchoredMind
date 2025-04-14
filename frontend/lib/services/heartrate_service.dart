import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HeartrateService {
  final Guid heartRateServiceUUID = Guid("0000180D-0000-1000-8000-00805F9B34FB");
  
  Stream<List<String>> scan() {
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      androidUsesFineLocation: true,
      withServices: [heartRateServiceUUID]
    );
    
    return FlutterBluePlus.scanResults.map(
      (results) => results
          .map((result) => result.device.platformName)
          .where((name) => name.isNotEmpty)
          .toSet()
          .toList(),
    );
  }

  Future<String> connectToDevice(String device) async {
    final completer = Completer<String>();
    
    StreamSubscription? subscription;
    subscription = FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        if (result.device.platformName == device) {
          await FlutterBluePlus.stopScan();
          await result.device.connect();
          completer.complete("Connected to ${result.device.platformName}");
          subscription?.cancel();
          break;
        }
      }
    });
    
    return completer.future;
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }
}