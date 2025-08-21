/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60.h,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.isAddingCart
                ? null
                :()=> controller.addToCart(false),
            style: ElevatedButton.styleFrom(
              elevation: 0, // for shadow effect
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              backgroundColor: AppColor
                  .dynamicColor, // background to support elevation
            ),
            child: controller.isAddingCart
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              "Add to cart",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.h,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
