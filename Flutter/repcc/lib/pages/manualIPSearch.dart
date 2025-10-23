import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:repcc/repcc.dart';
import 'package:repcc/globalvars.dart';

class manualIPSearchPage extends StatefulWidget {
  @override
  _manualIPSearchPageState createState() => _manualIPSearchPageState();
}

class _manualIPSearchPageState extends State<manualIPSearchPage> {

  //final GlobalVars globvars = Get.find(); //Hahaha globvars sounds funny xD

  String repccStateOk = "Failed...";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          //Ich mache eine Pause :(
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 390, height: 50, color: Colors.red),
              Container(width: 390, height: 744, color: Colors.grey),
              Container(width: 390, height: 50, color: Colors.red),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 390, height: 50),
              Align(
                alignment: Alignment.center,
                child: Stack (
                  children: [
                    Container(width: 350, height: 400, color: Colors.black),
                    Column (
                      children: [
                        Text("\$\> "+context.watch<GlobalVars>().connectIP, style: TextStyle(color: Colors.white)),
                        Text("\$\> Looking for your host...", style: TextStyle(color: Colors.white)),
                        Text("\$\> " + (REPCC().checkREPCCState(context.watch<GlobalVars>().connectIP, context.watch<GlobalVars>().connectPort) ? "Found!" : "Not found!"), style: TextStyle(color: Colors.white)),
                        Text("\$\> Authenticate with 2FA...", style: TextStyle(color: Colors.white)),
                        Text("\$\> Trying to connect...", style: TextStyle(color: Colors.white)),
                        Text("\$\> " + (REPCC().connect(context.watch<GlobalVars>().connectIP, context.watch<GlobalVars>().connectPort, context.watch<GlobalVars>().tfa) ? "Success!" : "Failed!"), style: TextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}