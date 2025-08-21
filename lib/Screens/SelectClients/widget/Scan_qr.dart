import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../controller/Search_by_controller.dart';

class ScanQr extends StatelessWidget {
  ScanQr({super.key});

  final LocationSearchController controller = Get.put(LocationSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title:  Text('Scan QR Code',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<LocationSearchController>(
        builder: (_) => Column(
          children: [
            Expanded(
              flex: 4,
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.green,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Obx(() => Text(
                  controller.scannedCode.value.isEmpty
                      ? 'Scan a code'
                      : 'Result: ${controller.scannedCode.value}',
                  style:  TextStyle(fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//when scan is done ger.back
