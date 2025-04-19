import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class HrService {
  final FlutterReactiveBle _ble;
  late StreamSubscription<DiscoveredDevice> _scanSubscription;
  late StreamController<List<String>> _deviceListController;
  late Stream<List<String>> _deviceListStream;

  // Constructor
  HrService(this._ble) {
    _deviceListController = StreamController<List<String>>.broadcast();
    _deviceListStream = _deviceListController.stream;
  }

  // Scan for devices with heart rate service
  void startScan() {
    // Start scanning for devices
    _scanSubscription = _ble.scanForDevices(withServices: [Uuid.parse('0000180d-0000-1000-8000-00805f9b34fb')]).listen((device) {
      if (device.name.isNotEmpty) {
        // Add discovered devices to the list stream
        _deviceListController.add([device.name]);
      }
    });
  }

  // Stop scanning
  void stopScan() {
    _scanSubscription.cancel();
  }

  // Connect to a specific heart rate device
  Future<void> connectToDevice(String deviceName) async {
    try {
      final device = await _ble.scanForDevices(withServices: [Uuid.parse('0000180d-0000-1000-8000-00805f9b34fb')]).firstWhere((device) => device.name == deviceName);
      await _ble.connectToDevice(id: device.id);
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  // Read the heart rate from a connected device
  Future<int?> readHeartRate() async {
    try {
      final characteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse('0000180d-0000-1000-8000-00805f9b34fb'),
        characteristicId: Uuid.parse('00002a37-0000-1000-8000-00805f9b34fb'),
        deviceId: 'your_device_id', // Replace with actual device ID
      );

      final data = await _ble.readCharacteristic(characteristic);
      if (data.isNotEmpty) {
        return data[0]; // The heart rate value is typically the first byte
      }
    } catch (e) {
      print('Error reading heart rate: $e');
    }
    return null;
  }

  // Getter for the stream of device names
  Stream<List<String>> get deviceListStream => _deviceListStream;
  
  // Dispose method to clean up resources
  void dispose() {
    _deviceListController.close();
    _scanSubscription.cancel();
  }
}
