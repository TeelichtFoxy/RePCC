import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RepccDeviceInfo extends StatelessWidget {
  final String os;
  final String name;
  final String ip;
  final String mac;
  final String repccversion;

  const RepccDeviceInfo({
    required this.os,
    required this.name,
    required this.ip,
    required this.mac,
    required this.repccversion
  });

  final String osImg = '''''';

  @override
  Widget build(BuildContext context) {
    return Container (
      width: 350,
      height: 110,
      color: Colors.white,
      child: Column (
        children: [
          Row (
            children: [
              SvgPicture.string(
                '''''',
                width: 50,
                height: 50
              ),
              Text(" "),
              Text(name),
              Text(" - "),
              Text(ip)
            ],
          ),
          Row (
            children: [
              Text("mac ", style: TextStyle(color: Colors.grey)),
              Text(mac, style: TextStyle(color: Colors.grey))
            ],
          ),
          Row (
            children: [
              Text("RePCC Version ", style: TextStyle(color: Colors.grey)),
              Text(repccversion, style: TextStyle(color: Colors.grey))
            ],
          )
        ],
      ).paddingAll(10),
    );
  }
}