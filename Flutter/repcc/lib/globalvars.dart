import 'package:flutter/foundation.dart';

class GlobalVars extends ChangeNotifier {
  String _connectIP = "0.0.0.0";
  int _connectPort = 15248;
  String _token = "";
  int _tfa = 000000;

  String get connectIP => _connectIP;
  int get connectPort => _connectPort;
  String get token => _token;
  int get tfa => _tfa;

  void changeConnectIP(String ip) {
    _connectIP = ip;
    notifyListeners();
  }

  void changeConnectPort(int port) {
    _connectPort = port;
    notifyListeners();
  }

  void changeToken(String token) {
    _token = token;
    notifyListeners();
  }

  void changeTFA(int tfa) {
    _tfa = tfa;
    notifyListeners();
  }
}