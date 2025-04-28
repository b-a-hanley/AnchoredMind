import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class HeartRateMonitor extends StatefulWidget {
  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late HrService _heartRateService;
  List<String> _deviceList = [];
  String _selectedDevice = '';
  int? _heartRate;

  @override
  void initState() {
    super.initState();
    _heartRateService = HrService(_ble);

    // Start scanning for devices
    _heartRateService.startScan();

    // Listen to the device list stream
    _heartRateService.deviceListStream.listen((deviceNames) {
      setState(() {
        _deviceList = deviceNames;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _heartRateService.dispose();
  }

  // Method to handle connecting to the selected device
  void _connectToDevice() async {
    if (_selectedDevice.isNotEmpty) {
      await _heartRateService.connectToDevice(_selectedDevice);
      _readHeartRate();
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('connected!')),
      );
  }

  // Method to read the heart rate from the connected device
  void _readHeartRate() async {
    int? heartRate = await _heartRateService.readHeartRate();
    setState(() {
      _heartRate = heartRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the list of devices
            _deviceList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Text('Select a Device:'),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedDevice.isEmpty ? null : _selectedDevice,
                        items: _deviceList.map((deviceName) {
                          return DropdownMenuItem<String>(
                            value: deviceName,
                            child: Text(deviceName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDevice = value ?? '';
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: _connectToDevice,
                        child: Text('Connect'),
                      ),
                    ],
                  ),

            SizedBox(height: 20),

            // Display the heart rate if available
            _heartRate == null
                ? Text('Heart rate not available')
                : Text('Heart Rate: $_heartRate bpm'),
          ],
        ),
      ),
    );
  }
}

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
