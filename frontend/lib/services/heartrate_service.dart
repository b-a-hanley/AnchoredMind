import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HeartrateService {
  final Guid heartRateServiceUUID = Guid("0000180D-0000-1000-8000-00805F9B34FB");
  Stream<List<ScanResult>> scanResults = FlutterBluePlus.scanResults;
  
  Stream<List<String>> scan() {
    FlutterBluePlus.startScan(
      timeout: Duration(seconds: 10),
    );

    scanResults = FlutterBluePlus.scanResults;
    return FlutterBluePlus.scanResults.map(
      (results) => results.map((result) => result.advertisementData.advName).toList(),
    );
  }

  Future<String> connectToDevice(String? device) async {
    final completer = Completer<String>();

    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult r in results) {
        if (r.advertisementData.advName == device) {
          await FlutterBluePlus.stopScan();
          await r.device.connect();
          completer.complete("Connected to ${r.device.platformName}");
          break;
        }
      }
    });

    return completer.future;
  }

  // void readHeartRateData(BluetoothCharacteristic characteristic) async {
  //   // Start listening to the characteristic to get heart rate data
  //   characteristic.setNotifyValue(true);
  //   characteristic.lastValueStream.listen((value) {
  //     // Parse the heart rate data from the value
  //     print('Heart Rate Data: $value');
  //   });
  // }
}
