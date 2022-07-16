import 'package:chatter/constants.dart';
import 'package:chatter/controller/home_controller.dart';
import 'package:chatter/model/chatter_user.dart';
import 'package:chatter/view/widgets/chat_list.dart';
import 'package:chatter/view/widgets/chatter_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.chatUser}) : super(key: key);
  final ChatterUser chatUser;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final controller = Get.find<HomeController>();
  TextEditingController chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatterConstants.secColor,
      body: SafeArea(
        child: SizedBox(
          height: 640.h,
          width: 360.w,
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: 360.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: ChatterConstants.priColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25.sp,
                    ),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.chatUser.fullName}",
                          style: Get.textTheme.bodyText1,
                        ),
                        Text(
                          "${widget.chatUser.email}",
                          style: Get.textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream:
                        FirebaseFirestore.instance.collection("chatter").doc("users").collection("chatter").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        controller.currentChat.value = controller.user.value.messages![widget.chatUser.id];
                        return Container(
                          width: 360.w,
                          padding: EdgeInsets.all(20.w),
                          child: Obx(
                            () {
                              return ListView.separated(
                                itemCount: controller.currentChat.length,
                                separatorBuilder: (context, index) {
                                  return 10.verticalSpace;
                                },
                                itemBuilder: (context, index) {
                                  return ChatList(index: index);
                                },
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.error_outline_rounded,
                            color: ChatterConstants.priColor,
                            size: 100.sp,
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ChatterConstants.priColor,
                            strokeWidth: 3.w,
                          ),
                        );
                      }
                    }),
              ),
              Container(
                height: 90.h,
                width: 360.w,
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ChatterTextField(
                        controller: chatController,
                        hint: "Type message",
                      ),
                    ),
                    10.horizontalSpace,
                    TextButton(
                      onPressed: () {
                        controller.sendMessage(
                          message: chatController,
                          receiverId: widget.chatUser.id!,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: ChatterConstants.priColor,
                        radius: 22.sp,
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
