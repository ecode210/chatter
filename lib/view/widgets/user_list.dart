import 'package:chatter/controller/home_controller.dart';
import 'package:chatter/view/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserList extends GetWidget<HomeController> {
  const UserList({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.currentChat.value = controller.user.value.messages![controller.allUsers[index].id];
        Get.to(() => Chat(chatUser: controller.allUsers[index]));
      },
      child: Container(
        height: 70.h,
        width: 320.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.sp,
            ),
            10.horizontalSpace,
            Text(
              "${controller.allUsers[index].fullName}",
              style: Get.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
