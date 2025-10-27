import 'package:flutter/material.dart';
import 'package:repcc/repcc.dart';

class TerminalSim extends StatelessWidget {
  final String ip;
  final int port;
  final int tfa;

  const TerminalSim ({
    required this.ip,
    required this.port,
    required this.tfa,
  });

  @override
  Widget build(BuildContext context) {
    final ahhhhhhh = REPCC().checkREPCCServiceState(ip, port);
    return FutureBuilder<bool>(
      future: ahhhhhhh,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot),
      child: Stack (
        children: [
          Container(width: 225, height: 125, color: Colors.black),
            Column (
              children: [
                Text("\$\> "+ip, style: TextStyle(color: Colors.white)),
                Text("\$\> Looking for your host...", style: TextStyle(color: Colors.white)),
                Text("\$\> " + (ahhhhhhh; ? "Found!" : "Not found!"), style: TextStyle(color: Colors.white)),
                Text("\$\> Authenticate with 2FA...", style: TextStyle(color: Colors.white)),
                Text("\$\> Trying to connect...", style: TextStyle(color: Colors.white)),
                Text("\$\> " + (REPCC().connect(ip, port, tfa) ? "Success!" : "Failed!"), style: TextStyle(color: Colors.white)),
              ],
            )
          ],
        ),
      );
  }
}