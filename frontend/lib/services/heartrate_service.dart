import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frontend/controllers/controller_manager.dart';
import 'package:frontend/controllers/heartrate_controller.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class HeartrateService {
  final Guid heartrateServiceUUID = Guid("0000180D-0000-1000-8000-00805F9B34FB");
  final Guid heartrateCharacteristicUUID = Guid("00002A37-0000-1000-8000-00805F9B34FB");
  final HeartrateController heartrateController = ControllerManager.instance.heartrateController;
  late BluetoothDevice heartrateDevice;
  final ValueNotifier<int> currentHeartrate = ValueNotifier<int>(0);
  
  Stream<List<String>> scan() {
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      androidUsesFineLocation: true,
      withServices: [heartrateServiceUUID]
    );
    
    return FlutterBluePlus.scanResults.map(
      (results) => results
          .map((result) => result.device.platformName)
          .where((name) => name.isNotEmpty)
          .toSet()
          .toList(),
    );
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<String> connectToDevice(String device) async {
    final completer = Completer<String>();
    
    StreamSubscription? subscription;
    subscription = FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        if (result.device.platformName == device) {
          await FlutterBluePlus.stopScan();
          await result.device.connect();
          heartrateDevice = result.device;
          completer.complete("Connected to ${result.device.platformName}");
          subscription?.cancel();
          break;
        }
      }
    });
    monitorHeartrate();
    return completer.future;
  }

  void storeDevice() {
    List<BluetoothDevice> connectedDevices = FlutterBluePlus.connectedDevices;
    DeviceIdentifier deviceId = connectedDevices.last.remoteId;
    //heartrateController.putProfile(heartrateDevice: deviceId.str);
  }

  String getDeviceName() {
    return heartrateDevice.platformName;
  }

  void monitorHeartrate() async {
    await heartrateDevice.connect(autoConnect: true);    

    final services = await heartrateDevice.discoverServices();
    final hrService = services.firstWhere((s) => s.uuid == heartrateServiceUUID);
    final hrChar = hrService.characteristics.firstWhere((c) => c.uuid == heartrateCharacteristicUUID);
    //heartrateController.putHeartrate(hrChar);
    await hrChar.setNotifyValue(true);

    hrChar.onValueReceived.listen((value) {
      final heartrate = parseHeartrate(value);
      currentHeartrate.value = heartrate;
      print(heartrate);
      //heartrateController.putHeartrate(heartrate);
    });
  } 


  int parseHeartrate(List<int> value) {
    if (value.isEmpty) return 0;
    final flags = value[0];
    final is16Bit = (flags & 0x01) != 0;
    return is16Bit ? (value[2] << 8) + value[1] : value[1];
  }

  // Future<String> reconnectToDevice() async {
  //   final completer = Completer<String>();
  //   String currentHeartrateDevice = localDbService.getProfileHeartrateDevice()!;

  //   StreamSubscription? subscription;
  //   subscription = FlutterBluePlus.scanResults.listen((results) async {
  //     for (ScanResult result in results) {
  //       if (result.device.remoteId.str == currentHeartrateDevice) {
  //         await FlutterBluePlus.stopScan();
  //         await result.device.connect();
  //         completer.complete("Connected to ${result.device.platformName}");
  //         subscription?.cancel();
  //         break;
  //       }
  //     }
  //   });

  //   return completer.future;
  // }
}