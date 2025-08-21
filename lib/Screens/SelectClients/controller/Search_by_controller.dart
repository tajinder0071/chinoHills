import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class LocationSearchController extends GetxController {
  final searchQuery = ''.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  final scannedCode = ''.obs;
  bool hasScanned = false; // prevents multiple back calls

  final allLocations = List.generate(
    10,
        (index) => {
      'title': 'Allure BH VIP \$index',
      'subtitle': '24 ml • Beverly Hills',
      'address': '201 South Lasky Suite #\$index',
      'image':
      'https://logos-world.net/wp-content/uploads/2023/02/Mayo-Clinic-Symbol.png',
    },
  );

  List<Map<String, String>> get filteredLocations {
    if (searchQuery.value.isEmpty) return allLocations;
    return allLocations
        .where((location) =>
    location['title']!.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        location['address']!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    qrController!.scannedDataStream.listen((scanData) {
      if (!hasScanned) {
        hasScanned = true;
        scannedCode.value = scanData.code ?? '';
        qrController!.pauseCamera();
        Future.delayed(Duration(milliseconds: 300), () {
          Get.back(result: scannedCode.value); // optionally return result
        });
      }
    });
  }

  void resumeCamera() => qrController?.resumeCamera();
  void pauseCamera() => qrController?.pauseCamera();

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}