import 'package:flutter/material.dart';

import 'package:repcc/pages/manualIP.dart';

class connectPage extends StatelessWidget {
  const connectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Top Safe Space
              Align(
                alignment: Alignment.topCenter,
                child: Container(width: 390, height: 50, color: Colors.red)
              ),
              //Background
              Align(
                child: Container(width: 390, height: 744, color: Colors.grey),
              ),
              //Bottom Safe Space
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(width: 390, height: 50, color: Colors.red)
              )
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 390, height: 50),
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