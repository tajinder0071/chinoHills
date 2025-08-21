import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../../CSS/color.dart';
import '../../../../CSS/image_page.dart';
import '../../../../common_Widgets/load_nfc.dart';
import '../../../../util/base_services.dart';
import '../../../../util/common_page.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  State<StatefulWidget> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  var result = ''.obs;
  var isLoading = false.obs;
  var isFlashOn = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar:
          commonAppBar(isLeading: true, title: "QR Code Scanner", action: []),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 8,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.blue,
                      borderRadius: 10.r,
                      borderLength: 30.h,
                      borderWidth: 10.w,
                      cutOutSize: 250.h,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Obx(
                      () => Text(
                        result.isNotEmpty
                            ? 'Scanned: ${result.value}'
                            : 'Scan a QR code',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => isLoading.value
                ? Positioned.fill(child: _buildLoadingScreen())
                : const SizedBox.shrink()),
            Positioned(
              top: 40,
              right: 20,
              child: Obx(
                () => GestureDetector(
                  onTap: _toggleFlash,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      isLoading.value = true;
      await controller.pauseCamera();
      await Future.delayed(const Duration(seconds: 2)); // Simulate processing
      isLoading.value = false;
      result.value = scanData.code ?? '';

      Get.log("Data is ${scanData.code}");
      if (result.value.isNotEmpty) {
        await scanReward(scanData.code);
      } else {
        _showResultPopup();
      }
      await controller.resumeCamera();
    });
  }

  var load = false;

  Future<void> scanReward(clinic_id) async {
    load = true;
    try {
      var response = await hitscanRewardAPI(clinic_id);
      load = false;
      print("available==>${response.data}");
      if (response.data != null) {
        print("Welcome!!");
        showAuthenticProductBottomSheet(Get.context!);
      } else {
        _showResultPopup();
      }
      setState(() {});
    } on Exception catch (e) {
      load = false;
      setState(() {});
    }
  }

  Future<void> _toggleFlash() async {
    await controller?.toggleFlash();
    isFlashOn.value = (await controller?.getFlashStatus()) ?? false;
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: double.infinity,
        child: NfcLoadingScreen(),
      ),
    );
  }

  void showAuthenticProductBottomSheet(BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: Colors.green, size: 50),
                const SizedBox(height: 10),
                const Text(
                  "Authentic Product",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Image.asset(AppImages.imageLogo, height: 60.h),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "OK",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResultPopup() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      contentPadding: EdgeInsets.all(5.h),
      backgroundColor: AppColor().background,
      radius: 15,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel, color: Colors.red, size: 30.spMax),
          SizedBox(height: 15.h),
          Text(
            'Invalid Qr Code',
            style: GoogleFonts.sarabun(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please Contact , Nima vendor ',
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(fontSize: 16.sp, color: Colors.black54),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
            ),
            child: Text(
              'Close',
              style: GoogleFonts.sarabun(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
