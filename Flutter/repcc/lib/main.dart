import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


class GlobalVars extends GetxController {
  final connectIP = "0.0.0.0".obs;

  void updateConnectIP(String newIP) {
    connectIP.value = newIP;
  }
}

void main() {
  Get.put(GlobalVars());
  runApp(const MyApp());
}

class AppColorScheme {
  static const colorb = Colors.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RePCC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogInPage(),
    );
  }
}

class manualIPSearchPage extends StatelessWidget {
  manualIPSearchPage({super.key});

  final GlobalVars globvars = Get.find(); //Hahaha globvars sounds funny xD
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          //Ich mache eine Pause :(
        ],
      )
    );
  }
}

class manualIPPage extends StatelessWidget {
  manualIPPage({super.key});

  final TextEditingController _oct1 = TextEditingController();
  final TextEditingController _oct2 = TextEditingController();
  final TextEditingController _oct3 = TextEditingController();
  final TextEditingController _oct4 = TextEditingController();

  @override
  void dispose() {
    _oct1.dispose();
    _oct2.dispose();
    _oct3.dispose();
    _oct4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Top Safe Space
              Align(
                alignment: Alignment.topCenter,
                child: Container(width: 390, height: 50, color: Colors.red),
              ),
              //Background
              Align(
                child: Container(width: 390, height: 744, color: Colors.grey),
              ),
              //Bottom Safe Space
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(width: 390, height: 50, color: Colors.red),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("RePCC", textScaler: TextScaler.linear(4)),
                    Text("Your all in one (Computer) remote")
                  ],
                ),
              ),
              Container(width: 390, height: 200, color: Colors.red),
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Enter your host's IP:"),
                  Container(width: 300, height: 50, color: const Color.fromARGB(255, 45, 45, 45), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    //OKT1
                    Container(width: 65, height: 40, color: Colors.white, child: TextField(
                      autofocus: true,
                      controller: _oct1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        if (value.length == 3) {
                          FocusScope.of(context).nextFocus();
                        }

                        if (int.tryParse(value)! < 0) {
                          _oct1.text = "0";
                        }

                        if (int.tryParse(value)! > 255) {
                          _oct1.text = "255";
                        }
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).nextFocus();
                      }
                    )
                    ),
                    //OKT2
                    Container(width: 65, height: 40, color: Colors.white, child: TextField(
                      controller: _oct2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        if (value.length == 3) {
                          FocusScope.of(context).nextFocus();
                        }

                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (int.tryParse(value)! < 0) {
                          _oct2.text = "0";
                        }

                        if (int.tryParse(value)! > 255) {
                          _oct2.text = "255";
                        }
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).nextFocus();
                      }
                    )
                    ),
                    //OKT3
                    Container(width: 65, height: 40, color: Colors.white, child: TextField(
                      controller: _oct3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        if (value.length == 3) {
                          FocusScope.of(context).nextFocus();
                        }

                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (int.tryParse(value)! < 0) {
                          _oct3.text = "0";
                        }

                        if (int.tryParse(value)! > 255) {
                          _oct3.text = "255";
                        }
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).nextFocus();
                      }
                    )
                    ),
                    //OKT4
                    Container(width: 65, height: 40, color: Colors.white, child: TextField(
                      controller: _oct4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (int.tryParse(value)! < 0) {
                          _oct4.text = "0";
                        }

                        if (int.tryParse(value)! > 255) {
                          _oct4.text = "255";
                        }
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).nextFocus();
                      }
                    )
                    ),
                  ])),
                  ElevatedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => manualIPSearchPage())
                    );
                  }, child: Text("SUBMIT"))
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

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

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
                child: Container(width: 390, height: 50, color: Colors.red),
              ),
              //Background
              Align(
                child: Container(width: 390, height: 744, color: Colors.grey)
              ),
              //Bottom Safe Space
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(width: 390, height: 50, color: Colors.red),
              ),
            ],
          ),
          //GUI
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150, width: 390),
              Stack (
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("Video"),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column (
                      children: [
                        Text("RePCC", textScaler: TextScaler.linear(4)),
                        Text("Your all in one (Computer) remote.")
                      ],
                    )
                  )
                ],
              ),
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 250, width: 390)
                ],
              ),
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const connectPage())
                    );
                  },
                  child: Text("Connect")
                  ),
                  ElevatedButton(onPressed: () {
                    final Uri _url = Uri.parse("https://github.com/teelichtfoxy/repcc/?tab=readme-ov-file#ios-setup-help");

                    Future<void> _launchUrl() async {
                      if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
                        throw Exception("ERROR");
                      }
                    }

                    _launchUrl();
                  },
                  child: Text("Set-Up Help")
                  )
                ],
              )
            ],
          )
        ]
      )
    );
  }
}