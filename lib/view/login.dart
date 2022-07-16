import 'package:chatter/constants.dart';
import 'package:chatter/controller/login_controller.dart';
import 'package:chatter/view/widgets/chatter_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends GetWidget<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatterConstants.secColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 640.h,
          width: 360.w,
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: 360.w,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ChatterConstants.priColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Chatter",
                  style: Get.textTheme.headline1!.copyWith(fontSize: 30.sp),
                ),
              ),
              Expanded(
                child: Container(
                  width: 360.w,
                  padding: EdgeInsets.all(20.w),
                  child: ListView(
                    children: [
                      10.verticalSpace,
                      ChatterTextField(
                        controller: controller.emailController,
                        hint: "Email",
                        icon: Icon(
                          Icons.person_rounded,
                          color: ChatterConstants.priColor,
                          size: 25.sp,
                        ),
                      ),
                      20.verticalSpace,
                      ChatterTextField(
                        controller: controller.passwordController,
                        hint: "Password",
                        icon: Icon(
                          Icons.password_rounded,
                          color: ChatterConstants.priColor,
                          size: 25.sp,
                        ),
                      ),
                      20.verticalSpace,
                      TextButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Container(
                          height: 50.h,
                          width: 320.w,
                          decoration: BoxDecoration(
                            color: ChatterConstants.priColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: Get.textTheme.headline3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
