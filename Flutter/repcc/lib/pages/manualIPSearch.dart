import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:repcc/repcc.dart';
import 'package:repcc/globalvars.dart';

import 'package:repcc/widgets/RepccDeviceInfo.dart';

class manualIPSearchPage extends StatefulWidget {
  @override
  _manualIPSearchPageState createState() => _manualIPSearchPageState();
}

class _manualIPSearchPageState extends State<manualIPSearchPage> {

  int hostthere = 2;
  int connected = 2;
  bool hostlooking = false;
  bool auth = false;
  bool tryconect = false;

  String _ip = "";
  int _port = 0;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_ip.isEmpty) {
      final globalvars = context.read<GlobalVars>();
      _ip = globalvars.connectIP;
      _port = globalvars.connectPort;

      _simTerminal();
    }
  }

  void _simTerminal() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        hostlooking = true;
      });
      print("A");

      bool serviceState = await REPCC().checkREPCCServiceState(context.watch<GlobalVars>().connectIP, context.watch<GlobalVars>().connectPort);

      if (!mounted) return;
      setState(() {
        hostthere = serviceState ? 1 : 0;
      });
    }
  
  
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
              Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.grey),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 390, height: 70),
              Align(
                alignment: Alignment.center,
                child: Column (
                  children: [
                    Text("RePCC", textScaler: TextScaler.linear(4)),
                    Text("Your all in one (Computer) remote"),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width, height: 200),
              Align(
                alignment: Alignment.center,
                child: Stack (
                  children: [
                    Container(width: 225, height: 125, color: Colors.black),
                    Column (
                      children: [
                        Text("\$\> "+context.watch<GlobalVars>().connectIP, style: TextStyle(color: Colors.white)),
                        Text(hostlooking ? ("\$\> Looking for your host...") : "", style: TextStyle(color: Colors.white)),
                        Text(hostlooking ? (((hostthere == 2) ? "" : (hostthere == 1) ? "\$\> Found!" : "\$\> Not found!")) : "", style: TextStyle(color: Colors.white),),
                        Text(auth ? ("\$\> Authenticate with 2FA...") : "", style: TextStyle(color: Colors.white)),
                        Text(tryconect ? ("\$\> Trying to connect...") : "", style: TextStyle(color: Colors.white)),
                        Text("\$\> " + (REPCC().connect(context.watch<GlobalVars>().connectIP, context.watch<GlobalVars>().connectPort, context.watch<GlobalVars>().tfa) ? "Success!" : "Failed!"), style: TextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
              RepccDeviceInfo(
                os: "MACOS",
                name: "Foxys MacBook Air",
                ip: context.watch<GlobalVars>().connectIP,
                mac: "AC-0E-FE-C2-5E-9D",
                repccversion: "1.0.1 (1)"
              )
            ],
          ),
        ],
      )
    );
  }
}