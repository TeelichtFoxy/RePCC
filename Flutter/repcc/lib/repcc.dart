import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

//Future<void> setupDioClient() async {
  //final dio = Dio();

  //(dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //final client = HttpClient();

    //client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      //final fingerprint = cert.sha256;

      //const expectedPin = "";

      //final isMatch = fingerprint == expectedPin;

      //return isMatch;
    //};
    //return client;
  //};
//}

class REPCC {
  Future<bool> checkREPCCServiceState(String ip, int port) async {
    final String _apiBaseUrl = "http://" + ip + ":" + port.toString();
    final uri = Uri.parse('$_apiBaseUrl/status');

    try {
      final response = await http.get(uri); 

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool checkREPCCState(String ip, int port) {
    final String _apiBaseUrl = "http://" + ip + ":" + port.toString();

    return false;
  }

  bool connect(String ip, int port, int tfa) {
    return false;
  }
}