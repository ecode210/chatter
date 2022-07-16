import 'package:chatter/constants.dart';
import 'package:chatter/controller/home_controller.dart';
import 'package:chatter/view/widgets/user_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends GetWidget<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatterConstants.secColor,
      body: SafeArea(
        child: SizedBox(
          height: 640.h,
          width: 360.w,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("chatter").doc("users").collection("chatter").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                controller.searchUserDatabase(snapshot: snapshot);
                controller.getAllUsers(snapshot: snapshot);
                return Column(
                  children: [
                    Container(
                      width: 360.w,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: ChatterConstants.priColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Chatter",
                              style: Get.textTheme.headline1,
                            ),
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello ${controller.user.value.fullName}",
                                    style: Get.textTheme.headline2,
                                  ),
                                  Text(
                                    "${controller.user.value.email}",
                                    style: Get.textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25.sp,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 360.w,
                        padding: EdgeInsets.all(20.w),
                        child: ListView.separated(
                          itemCount: controller.allUsers.length,
                          separatorBuilder: (context, index) {
                            return 10.verticalSpace;
                          },
                          itemBuilder: (context, index) {
                            return UserList(index: index);
                          },
                        ),
                      ),
                    ),
                  ],
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
            },
          ),
        ),
      ),
    );
  }
}
