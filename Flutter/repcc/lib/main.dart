import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("HI")
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
                      MaterialPageRoute(builder: (context) => const connectPage(),)
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