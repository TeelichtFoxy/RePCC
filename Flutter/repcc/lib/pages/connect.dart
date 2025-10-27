import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:repcc/pages/manualIP.dart';

class connectPage extends StatefulWidget {
  const connectPage({super.key});
  
  @override
  State<connectPage> createState() => _connectPageState();
}

class _connectPageState extends State<connectPage> {

  final MobileScannerController cameraController = MobileScannerController();
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Background
              Align(
                child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.grey),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 390, height: 70),
              Align(
                alignment: Alignment.center,
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("REPCC", textScaler: TextScaler.linear(4)),
                    Text("Your all in one (Computer) remote")
                  ],
                ),
              ),
              SizedBox(width: 390, height: 200),
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 250, height: 250, color: Colors.white),
                  ElevatedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => manualIPPage())
                    );
                  }, child: Text("Enter IP\nmanually"))
                ],
              )
            ],
          )
        ],
      )
    );
  }
}