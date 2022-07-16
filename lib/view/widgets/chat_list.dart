import 'package:chatter/constants.dart';
import 'package:chatter/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends GetWidget<HomeController> {
  const ChatList({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    if (controller.currentChat[index]["is_sender"]) {
      return Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.r),
            topRight: Radius.circular(100.r),
            bottomLeft: Radius.circular(100.r),
          ),
        ),
        alignment: Alignment.centerRight,
        child: Text(
          "${controller.currentChat[index]["message"]}",
          style: Get.textTheme.bodyText1,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: ChatterConstants.priColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.r),
            topRight: Radius.circular(100.r),
            bottomRight: Radius.circular(100.r),
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          "${controller.currentChat[index]["message"]}",
          style: Get.textTheme.bodyText1,
        ),
      );
    }
  }
}
