import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:repcc/globalvars.dart';

import 'package:repcc/pages/manualIPSearch.dart';

class manualIPPage extends StatefulWidget {
  @override
  _manualIPPageState createState() => _manualIPPageState();
}

class _manualIPPageState extends State<manualIPPage> {

  bool submitButtonActive = false;

  final TextEditingController _oct1 = TextEditingController();
  final TextEditingController _oct2 = TextEditingController();
  final TextEditingController _oct3 = TextEditingController();
  final TextEditingController _oct4 = TextEditingController();

  final TextEditingController _tfa1 = TextEditingController();
  final TextEditingController _tfa2 = TextEditingController();
  final TextEditingController _tfa3 = TextEditingController();
  final TextEditingController _tfa4 = TextEditingController();
  final TextEditingController _tfa5 = TextEditingController();
  final TextEditingController _tfa6 = TextEditingController();

  void checkIfReady() {
    if (_oct1.text != "" && _oct2.text != "" && _oct3.text != "" && _oct4.text != "" && _tfa1.text != "" && _tfa2.text != "" && _tfa3.text != "" && _tfa4.text != "" && _tfa5.text != "" && _tfa6.text != "") {
      setState(() {
        submitButtonActive = true;
      });
    } else {
      setState(() {
        submitButtonActive = false;
      });
    }
  }

  @override
  void dispose() {
    _oct1.dispose();
    _oct2.dispose();
    _oct3.dispose();
    _oct4.dispose();

    _tfa1.dispose();
    _tfa2.dispose();
    _tfa3.dispose();
    _tfa4.dispose();
    _tfa5.dispose();
    _tfa6.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globvars = context.read<GlobalVars>();
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

                        checkIfReady();
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

                        checkIfReady();
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

                        checkIfReady();
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

                        checkIfReady();
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).nextFocus();
                      }
                    )
                  ),
                  ])),
                  Text("TFA Code:"),
                  Container(width: 200, height: 50, color: const Color.fromARGB(255, 45, 45, 45), child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }

                        checkIfReady();
                      },
                    )),
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }

                        checkIfReady();
                      },
                    )),
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }

                        checkIfReady();
                      },
                    )),
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }

                        checkIfReady();
                      },
                    )),
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }

                        checkIfReady();
                      },
                    )),
                    Container(width: 25, height: 40, color: Colors.white, child: TextField(
                      controller: _tfa6,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      onChanged: (value) {
                        if (value == "") {
                          FocusScope.of(context).previousFocus();
                        }

                        checkIfReady();
                      },
                    )),
                  ])),
                  ElevatedButton(onPressed: submitButtonActive ? () {
                    String connectIP = _oct1.text + "." + _oct2.text + "." + _oct3.text + "." + _oct4.text;
                    int tfa = int.parse(_tfa1.text + _tfa2.text + _tfa3.text + _tfa4.text + _tfa5.text + _tfa6.text);

                    globvars.changeConnectIP(connectIP);
                    globvars.changeTFA(tfa);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => manualIPSearchPage())
                    );
                  } : null, child: Text("SUBMIT"))
                ],
              )
            ],
          )
        ],
      )
    );
  }
}