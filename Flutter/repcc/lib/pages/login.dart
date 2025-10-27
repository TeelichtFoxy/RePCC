import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:repcc/pages/connect.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        child: Stack (
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Background
              Align(
                child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.grey)
              )
            ]
          ),
          //GUI
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70, width: 390),
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
      )
    );
  }
}