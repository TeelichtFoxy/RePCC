import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class ObfuscationService {
  static encrypt.Key _getKey(String code) {
    String paddedCode = code.padRight(32, '0');

    return encrypt.Key.fromUtf8(paddedCode.substring(0, 32));
  }

  static encrypt.IV _genIV() {
    return encrypt.IV.fromSecureRandom(16);
  }

  static Map<String, String> obfuscate(String plainText, String tfaCode) {
    final key = _getKey(tfaCode);
    final iv = _genIV();
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7')
    );
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return {
      'data': encrypted.base64,
      'iv': iv.base64
    };
  }

  static String deobfuscate(Map<String, String> data, String tfaCode) {
    final key = _getKey(tfaCode);
    final iv = encrypt.IV.fromBase64(data['iv']!);
    final encrypted = encrypt.Encrypted.fromBase64(data['data']!);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7')
    );

    return encrypter.decrypt(encrypted, iv: iv);
  }
}

class REPCC {
  
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REPCC',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _navigateToConnectREPCCDeviceScreen();
  }

  void _navigateToConnectREPCCDeviceScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ConnectREPCCDeviceScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'REPCC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        )
      )
    );
  }
}

class ConnectREPCCDeviceScreen extends StatefulWidget {
  const ConnectREPCCDeviceScreen({super.key});

  @override
  State<ConnectREPCCDeviceScreen> createState() => _ConnectREPCCDeviceScreenState();
}

class _ConnectREPCCDeviceScreenState extends State<ConnectREPCCDeviceScreen> {
  String _networkStatus = 'Lokal (Port 15248)';
  String _connectingInformation = '';
  bool _isScanning = false;
  List<String> _scanResults = [];

  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _twofaController = TextEditingController();

  static const int targetPort = 15248;

  @override
  void initState() {
    super.initState();
    _setInitialIp();
  }

  Future<void> _setInitialIp() async {
    try {
      final info = NetworkInfo();
      String? ip = await info.getWifiIP();
      if (ip != null && ip.contains('.')) {
        final ipBase = ip.substring(0, ip.lastIndexOf('.') + 1);
        _ipController.text = '${ipBase}1';
        _networkStatus = 'Lokale IP-Basis: $ipBase';
      } else {
        _ipController.text = '192.168.1.1';
        _networkStatus = 'WLAN-Informationen nicht verfügbar.';
      }
    } catch (e) {
      _ipController.text = '192.168.1.1';
      _networkStatus = 'Fehler beim Abrufen der WLAN-IP.';
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  Future<void> _scanIPDevice() async {
    if (_isScanning) return;

    final targetIp = _ipController.text.trim();

    if (targetIp.isEmpty || !RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(targetIp)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte geben Sie eine gültige IP-Adresse ein.'), backgroundColor: Colors.red)
      );
      return;
    }

    setState(() {
      _isScanning = true;
      _scanResults = ['Prüfe $targetIp:$targetPort...'];
      _connectingInformation = 'Prüfe ob $targetIp ein REPCC Device ist und auf Verbindung wartet...';
    });

    const int timeout = 10000;

    await _connectREPCCDevice(targetIp, targetPort, timeout);

    if (mounted) {
      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _connectREPCCDevice(String ip, int port, int timeout) async {
    final url = Uri.parse('http://$ip:$port/youthere');
    String result = '';

    try {
      final response = await http.get(url).timeout(Duration(milliseconds: timeout));

      if (response.statusCode == 200) {
        result = 'GEFUNDEN: $ip (Status 200) -> Antwortgröße: ${response.body.length} Bytes';
      } else {
        result = 'NICHT GEFUNDEN: $ip (Status ${response.statusCode}), nicht 200';
      }
    } on TimeoutException {
      result = 'NICHT GEFUNDEN: $ip (Timeout nach ${timeout}ms)';
    } on SocketException {
      result = 'NICHT GEFUNDEN: $ip (Verbindung abgelehnt oder Host nicht erreichbar)';
    } catch (e) {
      result = 'FEHLER: $ip (Unbekannter Fehler: ${e.runtimeType})';
    }

    if (mounted) {
      setState(() {
        _scanResults.clear();
        _scanResults.add(result);
        _connectingInformation = result;
      });
    }

    if (result.contains('(Status 200)')) {
      final url = Uri.parse('http://$ip:$port/trytfa');

      final code = _twofaController.value;
      final obf = ObfuscationService.obfuscate(code.toString(), code.toString());
      final msg = obf['data'];
      final iv = obf['iv'];

      final String jsonBody = jsonEncode({
        'data': msg,
        'iv': iv
      });

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonBody
          ).timeout(Duration(milliseconds: timeout));

          if (response.statusCode == 200) {
            final String responseBody = response.body;

            if (responseBody.contains(code.toString())) {
              //Richtiger 2FA Code (PC Bestätigung)
              setState(() {
                _connectingInformation = '2FA Codes stimmen überein';
              });

              //Reserve REPCC Connection
              final url = Uri.parse('http://$ip:$port/reserveconnection');

              try {
                final response = await http.get(url).timeout(Duration(milliseconds: timeout));

                if (response.statusCode == 200) {
                  setState(() {
                    _connectingInformation = 'Reservieren der REPCC Verbindung erfolgreich.';
                  });

                  Future.delayed(Duration(milliseconds: 500));

                  setState(() {
                    _connectingInformation = 'Stelle Verbindung her...';
                  });

                  Future.delayed(Duration(milliseconds: 500));

                  setState(() {
                    _connectingInformation = 'Lade GUI...';
                  });
                } else {
                  setState(() {
                    _connectingInformation = 'Fehler beim reservieren der REPCC Verbindung (Status ${response.statusCode})';
                  });
                }
              } catch (e) {
                setState(() {
                  _connectingInformation = 'Fehler beim reservieren der REPCC Verbindung: ${e.runtimeType}';
                });
              }
            }
          }
      } catch (e) {
        setState(() {
          _connectingInformation = 'Fehler beim Überprüfen vom 2FA Code: ${e.runtimeType}';
        });
      }
    }
  }

  Future<void> _helpGetIP(String system) async {
    if (system == 'Win') {
      //WINDOWS
      final Uri url = Uri.parse('https://github.com/teelichtfoxy/repcc/#Find-IP-Windows');
      await launchUrl(url);
    } else if (system == 'Mac') {
      //MACOS
      final Uri url = Uri.parse('https://github.com/teelichtfoxy/repcc/#Find-IP-MacOS');
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect REPCC Device'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ziel-Port: 15248', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal)),
                  const SizedBox(height: 8),
                  Text('Status: $_networkStatus', style: TextStyle(fontSize: 14)),
                  const Text('Hinweis: Zielgerät muss HTTP-Anfragen auf diesem Port zulassen (keine lokale Firewall).', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('IP-Adresse vom PC herausfinden', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _helpGetIP('Win'),
                    child: Text('Windows', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () => _helpGetIP('Mac'),
                    child: Text('MacOS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text('IP-Adresse eingeben:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            TextField(
              controller: _ipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ziel-IP (z.B. 192.168.1.42)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.computer, color: Colors.teal),
                hintText: 'XXX.XXX.XXX.XXX',
              ),
              style: const TextStyle(fontSize: 17),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _twofaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '2FA Code vom PC (z.B. 123456)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                hintText: 'XXXXXX',
              ),
              style: const TextStyle(fontSize: 17),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _isScanning ? null : _scanIPDevice,
              icon: _isScanning
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.flash_on),
              label: Text(_isScanning ? 'Verbinden...' : 'Verbinden'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                elevation: 5,
              ),
            ),

            const SizedBox(height: 5),

            Text(_connectingInformation, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}