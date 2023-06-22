import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BleCommunication extends StatefulWidget {
  const BleCommunication({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BleCommunicationState createState() => _BleCommunicationState();
}

class _BleCommunicationState extends State<BleCommunication> {
  late BluetoothConnection connection;
  String receivedText = '';

  @override
  void initState() {
    super.initState();
    _connectToBluetoothDevice();
  }

  void _connectToBluetoothDevice() async {
    BluetoothDevice device;
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

    // 接続するBluetoothデバイスを選択（MACアドレスを指定）
    device =
        devices.firstWhere((device) => device.address == 'XX:XX:XX:XX:XX:XX');

    // Bluetoothデバイスに接続
    BluetoothConnection newConnection =
        await BluetoothConnection.toAddress(device.address);
    setState(() {
      connection = newConnection;
    });

    // データ受信を待機
    connection.input?.listen((Uint8List data) {
      setState(() {
        receivedText = String.fromCharCodes(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth Communication'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Received Text:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            receivedText,
            style: const TextStyle(fontSize: 20),
          ),
        ])));
  }
}
