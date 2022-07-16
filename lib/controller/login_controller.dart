import 'package:chatter/constants.dart';
import 'package:chatter/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      // Error dialog
      ChatterConstants.dialog(
        true,
        Container(
          height: 150.h,
          width: 250.w,
          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                color: ChatterConstants.priColor,
                size: 120.sp,
              ),
              Text(
                "Wrong Email/Password",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
      return;
    }

    // Loading dialog
    ChatterConstants.dialog(
      false,
      SizedBox(
        height: 100.h,
        width: 100.h,
        child: Center(
          child: CircularProgressIndicator(
            color: ChatterConstants.priColor,
            strokeWidth: 3.w,
          ),
        ),
      ),
    );

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        if (value.user != null) {
          Get.offAll(() => const Home());
        } else {
          Get.back();
        }
      });
    } on FirebaseAuthException catch (error) {
      debugPrint(error.message);
      Get.back();
      // Error Dialog
      ChatterConstants.dialog(
        true,
        Container(
          height: 160.h,
          width: 250.w,
          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                color: ChatterConstants.priColor,
                size: 120.sp,
              ),
              Text(
                "${error.message}",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
