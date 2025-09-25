import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Model/cart_model.dart';

import '../controller/confirm_controller.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({super.key, required this.cartData});

  RxList<Item> cartData;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmOrderController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Obx(() {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.dynamicColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed:
                  controller.isLoading.value ? null : () => controller.onNext(),
              child: controller.isLoading.value
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor().whiteColor),
                    ),
            );
          }),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.check_circle_outline,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const Text(
              "Get excited,\nyour order is confirmed!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "${cartData.length} item added to ‘My Treatments’",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Treatment card
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                return buildTreatmentCard(cartData[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTreatmentCard(Item treatment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              treatment.imageUrl.toString(),
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  treatment.itemType.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  treatment.name.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
