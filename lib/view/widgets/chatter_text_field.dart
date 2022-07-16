import 'package:chatter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatterTextField extends StatelessWidget {
  const ChatterTextField({Key? key, required this.controller, required this.hint, this.icon}) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: ChatterConstants.priColor,
      cursorRadius: Radius.circular(10.r),
      style: Get.textTheme.bodyText1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        fillColor: ChatterConstants.priColor.withOpacity(0.25),
        filled: true,
        prefixIcon: icon,
        hintStyle: Get.textTheme.bodyText1!.copyWith(color: ChatterConstants.priColor),
        hintText: hint,
      ),
    );
  }
}
