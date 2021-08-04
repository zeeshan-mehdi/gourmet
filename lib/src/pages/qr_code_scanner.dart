import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/product.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class _QRCodeScannerState extends State<QRCodeScanner> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(child: Text('Scan'),onPressed: ()async{

          String cameraScanResult = await scanner.scan();

          print(cameraScanResult);

          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProductWidget(routeArgument:RouteArgument(id: '0', param: cameraScanResult, heroTag: 'menu_tab'))));


        },),
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }


}
